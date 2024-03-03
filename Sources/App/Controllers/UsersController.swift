import Fluent
import Vapor
import GettingThingsDoneSharedDTO

struct UsersController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        api.post("register", use: register)
        api.post("login", use: login)

    }

    func register(req: Request) async throws -> RegistrationResponseDTO {
        
        //validate the user
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        //find if exists already
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "Username is already taken")
        }
        
        //hash the password
        user.password = try req.password.hash(user.password)
        
        //save the user to database
        try await user.save(on: req.db)
        
        return RegistrationResponseDTO(error: false)
        
    }
    
    func login(req: Request) async throws -> LoginResponseDTO {
        
        let user = try req.content.decode(User.self)
        
        guard let existingUser = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() else {
            return LoginResponseDTO(error: true, reason: "Username not found.")
        }
        
        let result = try await req.password.async.verify(user.password, created: existingUser.password)
        
        if !result {
            return LoginResponseDTO(error: true, reason: "Password is incorrect.")
        }
        
        // generate token and return it to the user
        let authPayload = try AuthPayload(expiration: .init(value: .distantFuture), userID: existingUser.requireID())
        return try LoginResponseDTO(error: false, token: req.jwt.sign(authPayload), userID: existingUser.requireID())

    }
}

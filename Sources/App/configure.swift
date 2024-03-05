import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    
    app.databases.use(.postgres(configuration: SQLPostgresConfiguration(hostname: "localhost", username: "postgres", password: "", database: "gethingsdonedb",  tls: .prefer(try .init(configuration: .clientDefault)))), as: .psql)
    
    app.migrations.add(CreateUsersTable())
    app.migrations.add(CreateCategoryTable())
    
    try app.register(collection: UsersController())
    try app.register(collection: GTDController())
    
    app.jwt.signers.use(.hs256(key: "SECRET KEY"))
    
    try routes(app)
}

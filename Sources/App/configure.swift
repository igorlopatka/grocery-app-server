import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    
    app.databases.use(.postgres(configuration: SQLPostgresConfiguration(hostname: "localhost", username: "postgres", password: "", database: "gethingsdonedb",  tls: .prefer(try .init(configuration: .clientDefault)))), as: .psql)
    
    app.migrations.add(CreateUsersTable())
    
    try app.register(collection: UsersController())
    
    
    try routes(app)
}

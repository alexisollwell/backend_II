-- =============================================
-- Script de Creación de Base de Datos B2B E-commerce
-- Motor: Microsoft SQL Server
-- =============================================

CREATE database e_commerce

USE e_commerce

-- 1. CREACIÓN DE TABLAS
-- =============================================

CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL DEFAULT 'User', -- 'Admin' o 'User'
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE ApiKeys (
    ApiKeyId INT IDENTITY(1,1) PRIMARY KEY,
    KeyName NVARCHAR(50) NOT NULL,
    KeyValue UNIQUEIDENTIFIER NOT NULL UNIQUE DEFAULT NEWID(),
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    SKU NVARCHAR(50) NOT NULL UNIQUE,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    Price DECIMAL(18,2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL FOREIGN KEY REFERENCES Users(UserId),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) NOT NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Pending' -- Pending, Completed, Cancelled
);

CREATE TABLE OrderDetails (
    OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderId),
    ProductId INT NOT NULL FOREIGN KEY REFERENCES Products(ProductId),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL
);
GO

-- 2. INSERCIÓN DE DATOS DE PRUEBA (SEEDING)
-- =============================================

-- Insertar Usuarios (Los passwords reales deben estar hasheados en la app)
INSERT INTO Users (Username, PasswordHash, Role) VALUES 
('admin_user', 'hash_simulado_123', 'Admin'),
('employee_01', 'hash_simulado_456', 'User');

-- Insertar API Keys para integraciones externas
INSERT INTO ApiKeys (KeyName, KeyValue) VALUES 
('ERP_Logistica', NEWID()),
('Proveedor_Webhooks', NEWID());

-- Insertar 50 Productos
INSERT INTO Products (SKU, Name, Description, Price, StockQuantity) VALUES 
('LAP-001', 'Laptop Pro 15', 'Laptop alto rendimiento 15 pulgadas', 1200.00, 50),
('LAP-002', 'Laptop Basic 14', 'Laptop uso diario 14 pulgadas', 600.00, 100),
('MON-001', 'Monitor 4K 27', 'Monitor resolución 4K de 27 pulgadas', 350.00, 30),
('MON-002', 'Monitor UltraWide 34', 'Monitor UltraWide ideal para programadores', 450.00, 25),
('KB-001', 'Teclado Mecánico RGB', 'Teclado mecánico con switches rojos', 80.00, 150),
('KB-002', 'Teclado Membrana', 'Teclado silencioso de oficina', 25.00, 200),
('MSE-001', 'Ratón Inalámbrico Pro', 'Ratón inalámbrico con batería recargable', 60.00, 120),
('MSE-002', 'Ratón Ergonómico', 'Ratón vertical para cuidado de muñeca', 45.00, 80),
('DK-001', 'Docking Station USB-C', 'Estación de conexión con 2 HDMI, Ethernet y USB', 120.00, 40),
('CBL-001', 'Cable HDMI 2m', 'Cable HDMI 2.1 trenzado', 15.00, 300),
('CBL-002', 'Cable USB-C 1.5m', 'Cable USB-C a USB-C de carga rápida', 12.00, 500),
('SRV-001', 'Servidor Rack 1U', 'Servidor de rack básico para pymes', 1500.00, 10),
('SRV-002', 'Servidor Torre', 'Servidor formato torre con gran almacenamiento', 1800.00, 5),
('STR-001', 'Disco Duro HDD 4TB', 'Disco duro mecánico para backups', 110.00, 60),
('STR-002', 'Disco Sólido NVMe 1TB', 'SSD de alta velocidad 7000MB/s', 130.00, 90),
('STR-003', 'Disco Sólido SSD 2TB', 'SSD SATA para almacenamiento general', 180.00, 45),
('NET-001', 'Router WiFi 6', 'Router inalámbrico de doble banda', 150.00, 35),
('NET-002', 'Switch Gigabit 24p', 'Switch gestionable de 24 puertos', 220.00, 15),
('NET-003', 'Access Point AC', 'Punto de acceso para techos', 90.00, 50),
('CAM-001', 'Webcam 1080p', 'Cámara web con micrófono integrado', 40.00, 150),
('CAM-002', 'Webcam 4K', 'Cámara web profesional para streaming', 120.00, 40),
('MIC-001', 'Micrófono de Condensador', 'Micrófono USB para podcasts', 85.00, 60),
('HS-001', 'Auriculares con Micrófono', 'Auriculares para call center', 35.00, 200),
('HS-002', 'Auriculares Inalámbricos', 'Auriculares Bluetooth con cancelación de ruido', 110.00, 75),
('PRT-001', 'Impresora Láser B/N', 'Impresora para gran volumen de texto', 200.00, 20),
('PRT-002', 'Impresora Multifunción', 'Imprime, escanea y fotocopia a color', 250.00, 15),
('INK-001', 'Tóner Negro', 'Cartucho de tóner genérico', 45.00, 80),
('INK-002', 'Cartucho Tinta Color', 'Pack de 3 colores para multifunción', 35.00, 100),
('UPS-001', 'UPS 1000VA', 'Sistema de alimentación ininterrumpida', 130.00, 25),
('UPS-002', 'UPS 1500VA', 'UPS para servidores pequeños', 210.00, 10),
('MBL-001', 'Smartphone Empresarial', 'Teléfono móvil con sistema de seguridad Knox', 550.00, 30),
('MBL-002', 'Tablet 10"', 'Tablet para firmas y catálogos', 250.00, 50),
('ACC-001', 'Funda Tablet', 'Funda resistente a caídas', 25.00, 100),
('ACC-002', 'Mochila Portátil', 'Mochila acolchada hasta 15.6"', 45.00, 80),
('SFW-001', 'Licencia Antivirus 1Y', 'Antivirus corporativo (1 usuario)', 35.00, 500),
('SFW-002', 'Suite Ofimática', 'Licencia anual de herramientas de oficina', 120.00, 300),
('CH-001', 'Silla Ergonómica', 'Silla de oficina con soporte lumbar', 180.00, 40),
('DK-002', 'Escritorio Elevable', 'Escritorio con ajuste eléctrico de altura', 350.00, 15),
('MON-003', 'Soporte Monitor Doble', 'Brazo mecánico para dos monitores', 65.00, 60),
('CBL-003', 'Adaptador USB-C a HDMI', 'Dongle convertidor de video', 20.00, 150),
('NET-004', 'Cable Red Cat6 5m', 'Cable Ethernet patch', 8.00, 400),
('NET-005', 'Patch Panel 24p', 'Panel de conexiones de red', 45.00, 20),
('STR-004', 'NAS 4 Bahías', 'Servidor de almacenamiento en red', 450.00, 10),
('MEM-001', 'Memoria RAM 16GB', 'DDR4 3200MHz SODIMM', 60.00, 120),
('MEM-002', 'Memoria RAM 32GB', 'DDR5 4800MHz DIMM', 130.00, 80),
('PWR-001', 'Fuente de Poder 650W', 'Fuente certificada 80 Plus Bronze', 75.00, 40),
('PWR-002', 'Cargador Universal Laptop', 'Cargador con múltiples puntas', 35.00, 90),
('SEC-001', 'Candado Seguridad Kensington', 'Candado para laptop', 25.00, 150),
('CLE-001', 'Kit Limpieza Pantallas', 'Spray y paño de microfibra', 10.00, 200),
('ORG-001', 'Organizador de Cables', 'Funda de neopreno con cierre', 15.00, 150);
GO

-- 3. PROCEDIMIENTOS ALMACENADOS (EJEMPLO)
-- =============================================
-- Este SP es un ejemplo claro de cómo recuperar datos de forma estructurada.
-- Las aplicaciones consumirán este SP usando Dapper / ADO.NET.

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetAllActiveProducts]
    @method varchar(100), 
    @isActive bit = null,
    @SKU varchar(50) = null
AS
BEGIN
    SET NOCOUNT ON;
    If @method = 'Products'
    BEGIN

        IF @isActive IS NULL
        BEGIN
            SELECT
                '0' as 'code',
                'No se ha especificado el parámetro isActive' as 'message'
            RETURN
        END



        SELECT 
            ProductId, 
            SKU, 
            Name, 
            Description, 
            Price, 
            StockQuantity,
            '1' as 'code',
            'Success' as 'message'
        FROM 
            Products
        WHERE 
            IsActive = @isActive
        ORDER BY 
            Name ASC;
    END

    If @method = 'GetProductBySKU'
    BEGIN
        IF @SKU IS NULL
        BEGIN
            SELECT
                '0' as 'code',
                'No se ha especificado el parámetro SKU' as 'message'
            RETURN
        END


        SELECT 
            @isActive = IsActive
        FROM Products
        WHERE SKU = @SKU

        IF @isActive = 0
        BEGIN
            SELECT
                '0' as 'code',
                'El producto ya no se encuentra activo' as 'message'
            RETURN
        END

        SELECT 
            ProductId, 
            SKU, 
            Name, 
            Description, 
            Price, 
            StockQuantity,
            '1' as 'code',
            'Success' as 'message'
        FROM 
            Products
        WHERE 
            SKU = @SKU
            AND IsActive = 1
        ORDER BY 
            Name ASC;
    END
END;
GO

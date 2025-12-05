
CREATE TABLE PRODUCTOS_PREMIUM(
    ID_Producto INT PRIMARY KEY,
    NOMBRE VARCHAR (50),
    PRECIO DECIMAL(10,2),
    USUARIO_ULTIMA_MODIFICACION VARCHAR (50) DEFAULT SYSTEM_USER
);

CREATE TABLE HISTORIAL_PRECIOS(
    ID_Auditoria INT IDENTITY(1,1) PRIMARY KEY,
    ID_Producto INT,
    PRECIO_ANTERIOR DECIMAL (10,2),
    PRECIO_NUEVO DECIMAL(10,2),
    FECHA_CAMBIO DATETIME DEFAULT GETDATE(),
    USUARIO_RESPONSABLE VARCHAR(50)
);

GO

--TRIGGER de adutoria

    CREATE TRIGGER TRG_Auditoria_Precios
    ON PRODUCTOS_PREMIUM
    AFTER UPDATE 
    AS 
    BEGIN 

        IF UPDATE(Precio)
        BEGIN 
            INSERT INTO HISTORIAL_PRECIOS(ID_Producto, PRECIO_ANTERIOR, PRECIO_NUEVO, )
            SELECT 
                i.ID_Producto,
                d.Precio,
                i.Precio,
                SYSTEM_USER
            FROM inserted i
            JOIN deleted d ON i.ID_Producto = d.ID_Producto;
            
            PRINT 'Cambio de precio registrado en el historial';

        END
    END;
    GO

    INSERT INTO PRODUCTOS_PREMIUM (ID_Producto, Nombre, Precio) VALUES
    (1, 'Iphone 15', 1200.00),
    (2, 'Samsung S24', 1100.00),
    (3, 'PlayStation 5', 800.00);
    GO

--Prueba de funcionamiento

    SELECT * FROM PRODUCTOS_PREMIUM;
    SELECT * FROM HISTORIAL_PRECIOS;

    UPDATE PRODUCTOS_PREMIUM 
    SET Precio = 1350.00 
    WHERE ID_Producto = 1;

    UPDATE PRODUCTOS_PREMIUM 
    SET Precio = 750.00 
    WHERE ID_Producto = 3;

    SELECT 
        ID_Auditoria,
        ID_Producto,
        PRECIO_ANTERIOR,
        PRECIO_NUEVO,
        DATEADD(HOUR, -3, FECHA_CAMBIO) AS Fecha_Argentina, 
        USUARIO_RESPONSABLE
    FROM HISTORIAL_PRECIOS; 
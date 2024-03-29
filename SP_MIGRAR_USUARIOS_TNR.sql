	USE tecnocob
	GO

	DECLARE                                    

			 @FECHA_CARGA                             DATETIME = GETDATE()
			,@FECHA_REFRESCO                          DATETIME = GETDATE()
			,@IDENTIFICADOR                           VARCHAR(255)
			,@NOMBRE_USUARIO						  VARCHAR(255)
			,@COD_USUARIO						      VARCHAR(255)

	DECLARE RECORRE_USUARIOS_TNR CURSOR FOR

				--SELECT DISTINCT 
				--			  USU.fld_cod_usu	
				--			 ,USU.fld_nom_usu
				--			 ,USU.fld_rut_usu
				--FROM          tecnocob..tmp_gestiones_tnr  GEST WITH(NOLOCK)  -- TABLA GESTIONES TANNER
				--INNER JOIN	  tecnocob..tbl_usuario        USU WITH(NOLOCK)
				--ON			  GEST.fld_cod_usu        =    USU.fld_cod_usu 
				--WHERE		  GEST.fld_cod_usu	     !=    'discador'	 
				
					
				SELECT DISTINCT 
							  USU.fld_cod_usu	
							 ,USU.fld_nom_usu
							 ,USU.fld_rut_usu
				FROM          tecnocob..tbl_historial  GEST WITH(NOLOCK)  -- TABLA GESTIONES TANNER
				INNER JOIN	  tecnocob..tbl_usuario        USU WITH(NOLOCK)
				ON			  GEST.fld_cod_usu        =    USU.fld_cod_usu 
				WHERE		  GEST.fld_cod_usu	     !=    'discador'	 
				AND           GEST.fld_cod_emp        =    'TNR'





	OPEN RECORRE_USUARIOS_TNR
	FETCH NEXT FROM RECORRE_USUARIOS_TNR
			INTO @COD_USUARIO,@NOMBRE_USUARIO,@IDENTIFICADOR  
	WHILE @@FETCH_STATUS = 0  
	BEGIN

	SET @NOMBRE_USUARIO = RTRIM(LTRIM(UPPER(@NOMBRE_USUARIO)))
	SET @IDENTIFICADOR =  IBR_ALO_V2.dbo.FN_QUITAR_CEROS_IZQ(@IDENTIFICADOR)

					  EXEC  IBR_ALO_V2..SP_CREATE_USUARIO
							  			    2,
											@NOMBRE_USUARIO,
											@COD_USUARIO,
											@COD_USUARIO,
											@IDENTIFICADOR,
											@COD_USUARIO,
											1

	FETCH NEXT FROM RECORRE_USUARIOS_TNR
			INTO @COD_USUARIO,@NOMBRE_USUARIO,@IDENTIFICADOR 
	END
	CLOSE RECORRE_USUARIOS_TNR
	DEALLOCATE RECORRE_USUARIOS_TNR







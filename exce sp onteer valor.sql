USE [IBR_ALO_CARGA_2]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_CREATE_CLIENTE]    Script Date: 16-07-2019 17:59:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_CREATE_EMAIL]
                       @NOMBRE                 VARCHAR(255)
					  ,@RUT                    VARCHAR(20)
					  ,@EMAIL                  VARCHAR(100)
				  
					  
As
Begin
SET ROWCOUNT 0
SET NOCOUNT ON
SET ANSI_NULLS OFF

/*-----------------------------------------------------------------*/  
/*                 DECLARACION DE VARIABLES GLOBALES               */  
/*-----------------------------------------------------------------*/

  DECLARE   @ID_CLIENTE             INT




/*-----------------------------------------------------------------*/  
/*              SETEA ID CEDENTE Y ID_CONTRATO                     */  
/*-----------------------------------------------------------------*/
  SELECT @ID_CEDENTE        =     EMP.ID_CEDENTE
        ,@ID_EMPRESA        =     EMP.ID_EMPRESA
  FROM  IBR_ALO..EMPRESA EMP      WITH(NOLOCK)
  WHERE EMP.DESCRIPCION     =     @EMPRESA           


  
/*-----------------------------------------------------------------*/  
/*                 VALIDACION TRY CATCH                            */  
/*-----------------------------------------------------------------*/ 
   BEGIN TRY  
   
/*-----------------------------------------------------------------*/  
/*          CREA CLIENTE A BASE DE DATOS IBR_ALO                   */  
/*-----------------------------------------------------------------*/ 
   EXEC @ID_CLIENTE =  IBR_ALO..SP_CREATE_CLIENTE_V2
                                        @ID_CEDENTE
                                       ,@ID_ESTADO_CLIENTE
                                       ,@IDENTIFICADOR
                                       ,@IDENTIFICADOR_2
                                       ,@NOMBRE
                                       ,@TRAMO
                                       ,@FECHA_CARGA
                                       ,@FECHA_REFRESCO
                                       ,@ESTADO
                                       ,@ORIGEN
                                       ,@NRO_CARGA
                                       ,@NRO_REGISTRO
									   ,0
                              
/*-----------------------------------------------------------------*/
/*          CREA CONTRATO A BASE DE DATOS IBR_ALO                  */
/*-----------------------------------------------------------------*/
   EXEC @ID_CONTRATO =  IBR_ALO..SP_CREATE_CONTRATO
                                          @ID_CLIENTE
                                         ,@ID_EMPRESA
                                         ,@NRO_CARGA
                                         ,@NRO_REGISTRO
										 ,0


   END TRY  
   BEGIN CATCH  
/*-----------------------------------------------------------------*/  
/*                REGISTRA ERROR EN TABLA LOG                      */  
/*-----------------------------------------------------------------*/ 
  -- EXEC SP_CARGA_CREATE_SOLICITUD_LOG @NRO_CARGA ,@NRO_REGISTRO ,@ID_SOLICITUD,@IDENTIFICADOR,@NAME_FILE

   END CATCH  

/*-----------------------------------------------------------------*/
/*------------------------- End User Code -------------------------*/
/*-----------------------------------------------------------------*/
End

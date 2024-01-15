interface ZIF_ADF_AZURE_DEFCONFIG
  public .


  constants GC_SERVICE_EVENTHUB type ZAZURE_DEST value 'EVENTHUB' ##NO_TEXT.
  constants GC_SERVICE_BLOB type ZAZURE_DEST value 'BLOB' ##NO_TEXT.
  constants GC_SERVICE_DOCDB type ZAZURE_DEST value 'DOCUMENTDB' ##NO_TEXT.
  constants GC_SERVICE_SERVICEBUS type ZAZURE_DEST value 'SERVICEBUS' ##NO_TEXT.
  constants GC_SERVICE_AAD type ZAZURE_DEST value 'AAD' ##NO_TEXT.
  constants GC_SERVICE_KEYVAULT type ZAZURE_DEST value 'KV' ##NO_TEXT.
  constants GC_SERVICE_COSMOSDB type ZAZURE_DEST value 'COSMOSDB' ##NO_TEXT.
  constants GC_SERVICE_LOG type ZAZURE_DEST value 'LOG' ##NO_TEXT.

  methods GET_CLASSNAME
    importing
      !I_INTERFACE_TYPE type ZAZURE_DEST
    returning
      value(R_CLASSNAME) type SEOCLNAME
    raising
      ZCX_ADF_SERVICE .
endinterface.

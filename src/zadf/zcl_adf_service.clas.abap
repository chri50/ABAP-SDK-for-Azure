class ZCL_ADF_SERVICE definition
  public
  abstract
  create public .

public section.

  constants GC_SERVICE_COSMOSDB type ZAZURE_DEST value 'COSMOSDB' ##NO_TEXT.
  constants GC_SAS type CHAR32 value 'SASTOKEN' ##NO_TEXT.
  constants GC_MI_AUTH type CHAR32 value 'Authorization' ##NO_TEXT.
  constants GC_SERVICE_BLOB type ZAZURE_DEST value 'BLOB' ##NO_TEXT.
  constants GC_SERVICE_AAD type ZAZURE_DEST value 'AAD' ##NO_TEXT.
  constants GC_SERVICE_KV type ZAZURE_DEST value 'KV' ##NO_TEXT.
  constants GC_REGEX type STRING value ',(?=(?:[^"]*$)|(?:[^"]*"[^"]*"[^"]*)*$)' ##NO_TEXT.
  constants GC_TAB type CHAR1 value CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB ##NO_TEXT.
  constants GC_SERVICE_MSI type ZAZURE_DEST value 'MSI' ##NO_TEXT.
  constants GC_SERVICE_APPINS type ZAZURE_DEST value 'APPINS' ##NO_TEXT.

  methods SEND
    importing
      value(REQUEST) type XSTRING
      !IT_HEADERS type TIHTTPNVP optional
    exporting
      value(RESPONSE) type STRING
      value(EV_HTTP_STATUS) type I
    raising
      ZCX_ADF_SERVICE .
  methods CONSTRUCTOR
    importing
      value(IV_INTERFACE_ID) type ZINTERFACE_ID
      value(IV_SERVICE_ID) type ZAZURE_DEST
      value(IV_BUSINESS_IDENTIFIER) type ZBUSINESSID optional
    raising
      ZCX_ADF_SERVICE
      ZCX_HTTP_CLIENT_FAILED
      ZCX_INTERACE_CONFIG_MISSING .
  methods FORMAT_DATA
    importing
      value(IV_FORMAT_TYPE) type ZADF_FORMAT_TYPE
      value(IT_DATA) type DATA
    returning
      value(RV_STRING) type STRING
    raising
      ZCX_ADF_SERVICE .
  methods FORMAT_DATA_TO_XML
    importing
      value(IT_DATA) type DATA
    returning
      value(RV_STRING) type STRING .
  methods FORMAT_DATA_TO_JSON
    importing
      value(IT_DATA) type DATA
    returning
      value(RV_STRING) type STRING .
  methods ADD_EXPIRY_TIME
    importing
      value(IV_EXPIRY_HOUR) type I
      value(IV_EXPIRY_MIN) type I default 30
      value(IV_EXPIRY_SEC) type I
    raising
      ZCX_ADF_SERVICE .
  methods URLENCODED_TO_HTTP_FIELDS
    importing
      !IV_RESPONSE_DATA type STRING
    returning
      value(ET_FIELDS) type TIHTTPNVP
    raising
      ZCX_ADF_SERVICE .
  methods JSON_TO_HTTP_FIELDS
    importing
      !IV_RESPONSE_DATA type STRING
    returning
      value(ET_FIELDS) type TIHTTPNVP
    raising
      ZCX_ADF_SERVICE .
  methods GET_MESSAGE_ID
    returning
      value(RV_MESSAGE_ID) type GUID_16 .
  methods TXT_XSTRING_TO_INT_TABLE
    importing
      !RESPONSE type XSTRING
    exporting
      !GT_DATA type ANY TABLE
    raising
      ZCX_ADF_SERVICE .
  methods CSV_XSTRING_TO_INT_TABLE
    importing
      !RESPONSE type XSTRING
    exporting
      !GT_DATA type ANY TABLE
    raising
      ZCX_ADF_SERVICE .
  methods INT_TABLE_TO_TEXT_XSTRING
    importing
      value(IT_DATA) type TABLE optional
    exporting
      value(EV_XSTRING) type XSTRING
    raising
      ZCX_ADF_SERVICE .
protected section.

  data GV_URI type STRING .
  constants GC_ERROR type CHAR1 value 'E' ##NO_TEXT.
  data GV_INTERFACE_ID type ZINTERFACE_ID .
  data GV_SAS_KEY type STRING .
  data GO_REST_API type ref to ZCL_REST_FRAMEWORK .
  data GV_ASYNCHRONOUS type ABAP_BOOL .
  data GV_IS_TRY type ABAP_BOOL .
  data GV_EXPIRY_HOUR type I .
  data GV_EXPIRY_MIN type I .
  data GV_EXPIRY_SEC type I .
  data GV_STRING_TO_SIGN type STRING .
  data GV_SERVICE_VERSION type STRING .
  data GV_RFC_DESTINATION type RFCDEST .
  data GV_PATH_PREFIX type STRING .
  data GV_HOST type STRING .
  data GT_HEADERS type TIHTTPNVP .

  methods ADD_REQUEST_HEADER
    importing
      value(IV_NAME) type STRING
      value(IV_VALUE) type STRING .
  methods GET_SAS_TOKEN
    importing
      value(IV_BASEADDRESS) type STRING
    returning
      value(RV_SAS_TOKEN) type STRING
    raising
      ZCX_ADF_SERVICE .
  methods GET_EPOCH_TIME
    returning
      value(RV_EXPIRY_TIME) type STRING
    raising
      ZCX_ADF_SERVICE .
  methods DECODE_SIGN
    returning
      value(RV_SECRET) type STRING
    raising
      ZCX_ADF_SERVICE .
  methods GET_TARGET_HOST
    importing
      !IV_DESTINATION type RFCDES-RFCDEST
      !IV_AUTHORITY_CHECK type RFCDISPLAY-RFCTRACE optional
      !IV_BYPASS_BUFF type CHAR1 optional
    exporting
      !EV_SERVER type RFCDISPLAY-RFCHOST
      !EV_PATH_PREFIX type STRING
    raising
      ZCX_ADF_SERVICE .
  methods READ_SSF_KEY
    returning
      value(RV_KEY) type STRING
    raising
      ZCX_ADF_SERVICE .
  methods READ_KEY
    returning
      value(RV_KEY) type STRING
    raising
      ZCX_ADF_SERVICE .
  methods CHECK_SWITCH_TO_MI
    importing
      value(IV_INTERFACE_ID) type ZINTERFACE_ID
    exporting
      value(EV_SWITCH_TO_MI) type BOOLEAN .
private section.

  constants GC_FORMAT_XML type ZADF_FORMAT_TYPE value 'XML' ##NO_TEXT.
  constants GC_FORMAT_JSON type ZADF_FORMAT_TYPE value 'JSON' ##NO_TEXT.
  constants GC_ASYNCHRONOUS type CHAR1 value 'A' ##NO_TEXT.
  constants GC_SYNCHRONOUS type CHAR1 value 'S' ##NO_TEXT.
  data GV_DESTINATION type ZAZURE_DEST .
  data GV_SERVICE_ID type ZAZURE_DEST .
  data GV_METHOD_CALL type CHAR20 .

  methods GET_INTERFACE_DETAILS
    raising
      ZCX_ADF_SERVICE .
  methods GET_REST_API_REF
    importing
      !IV_BUSINESS_IDENTIFIER type ZBUSINESSID optional
    raising
      ZCX_ADF_SERVICE
      ZCX_HTTP_CLIENT_FAILED
      ZCX_INTERACE_CONFIG_MISSING .
  methods CALL_STACK_CHECK
    raising
      ZCX_ADF_SERVICE .
  methods SWITCH_SERVICE_ID
    importing
      value(IV_INTERFACE_ID) type ZINTERFACE_ID
      value(IV_SERVICE_ID) type ZAZURE_DEST
    exporting
      value(EV_SERVICE_ID) type ZAZURE_DEST .
ENDCLASS.



CLASS ZCL_ADF_SERVICE IMPLEMENTATION.
ENDCLASS.

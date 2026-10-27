@EndUserText.label : 'RAP Indemnisation Request'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zrap_indem_req {
  key client                : abap.clnt not null;
  key request_uuid          : sysuuid_x16 not null;

  requester                 : abap.char(12);
  amount                    : abap.curr(15,2);
  currency_code             : abap.cuky;
  request_date              : abap.dats;
  reason                    : abap.char(255);
  status                    : abap.char(12);
  reviewer                  : abap.char(12);
  decision_reason           : abap.char(255);
  payment_reference         : abap.char(35);

  @Semantics.user.createdBy: true
  created_by                : abp_creation_user;
  @Semantics.systemDateTime.createdAt: true
  created_at                : abp_creation_tstmpl;
  @Semantics.user.lastChangedBy: true
  last_changed_by           : abp_lastchange_user;
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at           : abp_lastchange_tstmpl;
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at     : abp_locinst_lastchange_tstmpl;
}

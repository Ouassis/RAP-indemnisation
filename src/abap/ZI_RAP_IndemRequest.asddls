@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Indemnisation Request'
@Metadata.allowExtensions: true
define root view entity ZI_RAP_IndemRequest
  as select from zrap_indem_req
{
  key request_uuid as RequestUUID,

      requester as Requester,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      amount as Amount,

      @Semantics.currencyCode: true
      currency_code as CurrencyCode,

      request_date as RequestDate,
      reason as Reason,
      status as Status,
      reviewer as Reviewer,
      decision_reason as DecisionReason,
      payment_reference as PaymentReference,

      @Semantics.user.createdBy: true
      created_by as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at as CreatedAt,

      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}

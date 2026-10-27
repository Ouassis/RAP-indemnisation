@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Indemnisation Requests'
@Metadata.allowExtensions: true
define root view entity ZC_RAP_IndemRequest
  provider contract transactional_query
  as projection on ZI_RAP_IndemRequest
{
  key RequestUUID,
      Requester,
      Amount,
      CurrencyCode,
      RequestDate,
      Reason,
      Status,
      Reviewer,
      DecisionReason,
      PaymentReference,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt
}

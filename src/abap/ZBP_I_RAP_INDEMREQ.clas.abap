CLASS zbp_i_rap_indemreq DEFINITION
  PUBLIC
  ABSTRACT
  FINAL
  FOR BEHAVIOR OF zi_rap_indemrequest.
ENDCLASS.

CLASS zbp_i_rap_indemreq IMPLEMENTATION.
ENDCLASS.

CLASS lhc_Request DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Request~setInitialStatus.

    METHODS validateRequest FOR VALIDATE ON SAVE
      IMPORTING keys FOR Request~validateRequest.

    METHODS Submit FOR MODIFY
      IMPORTING keys FOR ACTION Request~Submit RESULT result.

    METHODS Approve FOR MODIFY
      IMPORTING keys FOR ACTION Request~Approve RESULT result.

    METHODS Reject FOR MODIFY
      IMPORTING keys FOR ACTION Request~Reject RESULT result.
ENDCLASS.

CLASS lhc_Request IMPLEMENTATION.

  METHOD setInitialStatus.
    READ ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(requests).

    MODIFY ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR request IN requests
        WHERE ( Status IS INITIAL )
        ( %tky = request-%tky
          Status = 'DRAFT' ) ).
  ENDMETHOD.

  METHOD validateRequest.
    READ ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      FIELDS ( Requester Amount CurrencyCode RequestDate Reason Status DecisionReason )
      WITH CORRESPONDING #( keys )
      RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).
      IF request-Requester IS INITIAL
        OR request-CurrencyCode IS INITIAL
        OR request-RequestDate IS INITIAL
        OR request-Reason IS INITIAL.
        APPEND VALUE #( %tky = request-%tky ) TO failed-Request.
        APPEND VALUE #(
          %tky = request-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Requester, currency, request date, and reason are required.' )
        ) TO reported-Request.
      ENDIF.

      IF request-Amount <= 0.
        APPEND VALUE #( %tky = request-%tky ) TO failed-Request.
        APPEND VALUE #(
          %tky = request-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Amount must be greater than zero.' )
        ) TO reported-Request.
      ENDIF.

      IF request-Status = 'REJECTED' AND request-DecisionReason IS INITIAL.
        APPEND VALUE #( %tky = request-%tky ) TO failed-Request.
        APPEND VALUE #(
          %tky = request-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'A rejection reason is required.' )
        ) TO reported-Request.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD Submit.
    READ ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).
      IF request-Status <> 'DRAFT'.
        APPEND VALUE #( %tky = request-%tky ) TO failed-Request.
        APPEND VALUE #(
          %tky = request-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Only draft requests can be submitted.' )
        ) TO reported-Request.
      ENDIF.
    ENDLOOP.

    MODIFY ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR request IN requests
        WHERE ( Status = 'DRAFT' )
        ( %tky = request-%tky Status = 'SUBMITTED' ) ).

    READ ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated).

    result = VALUE #( FOR row IN updated
      ( %tky = row-%tky %param = row ) ).
  ENDMETHOD.

  METHOD Approve.
    READ ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).
      IF request-Status <> 'SUBMITTED'.
        APPEND VALUE #( %tky = request-%tky ) TO failed-Request.
        APPEND VALUE #(
          %tky = request-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Only submitted requests can be approved.' )
        ) TO reported-Request.
      ENDIF.
    ENDLOOP.

    MODIFY ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR request IN requests
        WHERE ( Status = 'SUBMITTED' )
        ( %tky = request-%tky Status = 'APPROVED' ) ).

    READ ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated).

    result = VALUE #( FOR row IN updated
      ( %tky = row-%tky %param = row ) ).
  ENDMETHOD.

  METHOD Reject.
    READ ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      FIELDS ( Status DecisionReason )
      WITH CORRESPONDING #( keys )
      RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).
      IF request-Status <> 'SUBMITTED'.
        APPEND VALUE #( %tky = request-%tky ) TO failed-Request.
        APPEND VALUE #(
          %tky = request-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Only submitted requests can be rejected.' )
        ) TO reported-Request.
      ELSEIF request-DecisionReason IS INITIAL.
        APPEND VALUE #( %tky = request-%tky ) TO failed-Request.
        APPEND VALUE #(
          %tky = request-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Enter a decision reason before rejecting the request.' )
        ) TO reported-Request.
      ENDIF.
    ENDLOOP.

    MODIFY ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR request IN requests
        WHERE ( Status = 'SUBMITTED' AND DecisionReason IS NOT INITIAL )
        ( %tky = request-%tky Status = 'REJECTED' ) ).

    READ ENTITIES OF zi_rap_indemrequest IN LOCAL MODE
      ENTITY Request ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated).

    result = VALUE #( FOR row IN updated
      ( %tky = row-%tky %param = row ) ).
  ENDMETHOD.

ENDCLASS.

* IMPORTANT:
* This is a reviewable starter, not a verified activation-ready class pool.
* The target SAP release and generated RAP types determine exact syntax and
* required authorization handlers. Implement instance authorization before
* exposing the service; see docs/security.md and docs/implementation-backlog.md.

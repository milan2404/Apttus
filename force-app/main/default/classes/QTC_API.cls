public abstract class QTC_API {
    private static String serverURL {
        get {
            if (String.isBlank(serverURL)) {
                serverUrl =
                    URL.getSalesforceBaseUrl().toExternalForm() +
                    '/services/Soap/u/55.0/' +
                    UserInfo.getOrganizationId();
            }
            return serverURL;
        }
        private set;
    }

    private static String sessionId {
        get {
            if (String.isBlank(sessionId)) {
                sessionId = UserInfo.getSessionId();
            }
            return sessionId;
        }
        private set;
    }

    public static List<Apttus_Billing.DirectCreditMemoResult> createDirectCreditMemos(
        List<Apttus_Billing.DirectCreditMemoInput> listCreditMemoInput
    ) {
        return Apttus_Billing.BillingService.createDirectCreditMemos(listCreditMemoInput);
    }

    public static List<Apttus_Billing.RelatedARTransactionService.RelatedARTxnResult2> applyCreditMemo(
        List<Apttus_Billing.RelatedARTransactionService.RelatedARTxnInput2> listRelatedARTxnInput
    ) {
        return Apttus_Billing.RelatedARTransactionService.applyCreditMemosToInvoices(
            listRelatedARTxnInput
        );
    }

    public static void calculateInvoiceTax(Set<Id> setInvoiceId, Boolean autoApprove) {
        Apttus_Billing.BillingService.updateInvoiceTaxCalculationsAndBreakups(
            setInvoiceId,
            autoApprove
        );
    }

    public static void calculateCreditMemoTax(Set<Id> setCreditMemoId, Boolean autoApprove) {
        Apttus_Billing.BillingService.updateCreditMemoTaxCalculationsAndBreakups(
            setCreditMemoId,
            autoApprove
        );
    }

    public static Boolean syncWithOpportunity(Id proposalId, Boolean includingOption) {
        return Apttus_QPConfig.QPConfigWebService.syncWithOpportunity(proposalId, includingOption);
    }

    public static Boolean submitForApproval(Set<Id> setId, String strObjectType) {
        List<Apttus_Approval.BulkCtxObjectParam> listBulkCtxObjectParam = new List<Apttus_Approval.BulkCtxObjectParam>();
        Apttus_Approval.BulkCtxObjectParam objBulkCtxObjectParam;
        for (Id objectId : setId) {
            objBulkCtxObjectParam = new Apttus_Approval.BulkCtxObjectParam();
            objBulkCtxObjectParam.ctxSObjectType = strObjectType;
            objBulkCtxObjectParam.ctxSObjectId = objectId;
            objBulkCtxObjectParam.comments = null;
            listBulkCtxObjectParam.add(objBulkCtxObjectParam);
        }
        return Apttus_Approval.ApprovalsWebService.submitForApprovalsBulk(listBulkCtxObjectParam);
    }

    public static Boolean approveRequest(Id approvalRequestId, String strComment) {
        try {
            return Apttus_Approval.ApprovalsWebService.approveRequest(
                approvalRequestId,
                strComment
            );
        } catch (Exception ex) {
            return false;
        }
    }

    public static Boolean previewApprovals(String strObjectType, Id creditMemoId) {
        try {
            return Apttus_Approval.ApprovalsWebService.previewApprovals(
                strObjectType,
                creditMemoId
            );
        } catch (Exception ex) {
            return false;
        }
    }

    public static Apttus__APTS_Template__c getTemplate(
        Id sObjectId,
        String templateType,
        String queryTemplateType
    ) {
        return Apttus.AgreementWebService.selectFirstTemplateForSObject(
            sObjectId,
            templateType,
            queryTemplateType
        );
    }

    public static Id generateProposalDocument(Id templateId, Id proposalId) {
        return generateProposalDocument(templateId, proposalId, 'Read only', 'PDF', false);
    }

    public static Id generateProposalDocument(
        Id templateId,
        Id proposalId,
        String pLevel,
        String docFormat,
        Boolean isDraft
    ) {
        return Apttus_Proposal.MergeWebService.generateDoc2(
            templateId,
            proposalId,
            pLevel,
            docFormat,
            isDraft,
            sessionId,
            serverUrl
        );
    }
}
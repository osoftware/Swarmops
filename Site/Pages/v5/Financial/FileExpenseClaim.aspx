﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master-v5.master" AutoEventWireup="true" Inherits="Swarmops.Frontend.Pages.v5.Financial.FileExpenseClaim" Codebehind="FileExpenseClaim.aspx.cs" %>
<%@ Register src="~/Controls/v5/Base/FileUpload.ascx" tagname="FileUpload" tagprefix="Swarmops5" %>
<%@ Register TagPrefix="Swarmops5" TagName="ComboBudgets" Src="~/Controls/v5/Financial/ComboBudgets.ascx" %>
<%@ Register TagPrefix="Swarmops5" TagName="CurrencyAmount" Src="~/Controls/v5/Financial/CurrencyTextBox.ascx" %>

<asp:Content ID="Content4" ContentPlaceHolderID="PlaceHolderHead" Runat="Server">

    <script type="text/javascript">

        $(document).ready(function () {
 
            <asp:Repeater ID="RepeaterTagDropScript" runat="server"><ItemTemplate>
            $('#DropTags<%# Eval("TagSetId") %>').combotree({
                animate: true,
                height: 30
            });

            
            $('#SpanDropTags<%# Eval("TagSetId") %> span.combo input.combo-text').click(function () {
                $('#SpanDropTags<%# Eval("TagSetId") %> span.combo span span.combo-arrow').click();
            });
            </ItemTemplate></asp:Repeater>

        });





        function validateFields() {
            var isValid = true;
            
            isValid = validateTextField('#<%=this.TextAccount.ClientID %>', SwarmopsJS.unescape('<%= this.Localized_ValidationError_BankAccount %>')) && isValid;
            isValid = validateTextField('#<%=this.TextClearing.ClientID %>', SwarmopsJS.unescape('<%= this.Localized_ValidationError_BankClearing %>')) && isValid;
            isValid = validateTextField('#<%=this.TextBank.ClientID %>', SwarmopsJS.unescape('<%= this.Localized_ValidationError_BankName %>')) && isValid;

            if ($('#<%=this.ComboBudgets.ClientID %>_DropBudgets').combotree('tree').tree('getSelected') == null) {
                isValid = false;
                $('#<%=this.ComboBudgets.ClientID %>_SpanBudgets').addClass("entryError");
                alertify.error(SwarmopsJS.unescape('<%= this.Localized_ValidationError_Budget %>'));
            }

            <asp:Repeater ID="RepeaterErrorCheckTags" runat="server"><ItemTemplate>
                if ($('#DropTags<%# Eval("TagSetId") %>').combotree('tree').tree('getSelected') == null) {
                    isValid = false;
                    $('#SpanDropTags<%# Eval("TagSetId") %>').addClass("entryError");
                    alertify.error(SwarmopsJS.unescape('<%=this.Localized_ValidationError_MissingTag %>'));
                }
            </ItemTemplate></asp:Repeater>

            isValid = validateTextField('#<%=this.TextPurpose.ClientID %>', SwarmopsJS.unescape('<%= this.Localized_ValidationError_Purpose %>')) && isValid;

            var jsonData = {};
            jsonData.amount = <%=this.CurrencyAmount.ClientID %>_val();

            $.ajax({
                type: "POST",
                url: "/Automation/FieldValidation.aspx/IsAmountValid",
                data: $.toJSON(jsonData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,  // blocks until function returns - race conditions otherwise
                success: function (msg) {
                    if (msg.d != true) {
                        isValid = false;
                        $('#<%=this.CurrencyAmount.ClientID %>_TextInput').addClass("entryError");
                        alertify.error(SwarmopsJS.unescape('<%= this.Localized_ValidationError_Amount %>'));
                        <%=this.CurrencyAmount.ClientID %>_focus();
                    }
                }
            });

            $.ajax({
                type: "POST",
                url: "/Automation/FieldValidation.aspx/AreDocumentsUploaded",
                data: "{'guidString': '<%=this.FileUpload.GuidString %>'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,  // blocks until function returns - race conditions otherwise
                success: function (msg) {
                    if (msg.d != true) {
                        isValid = false;
                        $('#TextAmount').addClass("entryError");
                        alertify.error(SwarmopsJS.unescape('<%= this.Localized_ValidationError_Documents %>'));
                    }
                }
            });

            return isValid;
        }
        
        function validateTextField (fieldId, message) {
            if ($(fieldId).val().length == 0) {
                alertify.error(message);
                $(fieldId).addClass("entryError");
                $(fieldId).focus();
                return false;
            }

            return true;
        }

    </script>
</asp:Content>


<asp:Content ID="Content5" ContentPlaceHolderID="PlaceHolderMain" Runat="Server">
    <h2><asp:Label runat="server" ID="BoxTitle" /></h2>
    <asp:HiddenField ID="HiddenTagSetIdentifiers" runat="server"/>
    <div class="entryFields">
        <Swarmops5:CurrencyAmount runat="server" ID="CurrencyAmount" />
        <div class="stacked-input-control"><asp:TextBox runat="server" ID="TextPurpose" /></div>
        <Swarmops5:ComboBudgets ID="ComboBudgets" runat="server" />
        <asp:Repeater ID="RepeaterTagDrop" runat="server"><ItemTemplate><span id="SpanDropTags<%# Eval("TagSetId") %>"><select class="easyui-combotree" url="/Automation/Json-TransactionTagsTree.aspx?TagSetId=<%# Eval("TagSetId") %>" name="DropTags<%# Eval("TagSetId") %>" id="DropTags<%# Eval("TagSetId") %>" animate="true" style="width:300px"></select></span>&nbsp;<br/></ItemTemplate></asp:Repeater>

        <div class="stacked-input-control"></div><!-- placeholder for label-side H2 -->
        
        <!-- file upload begins here -->
        
        <Swarmops5:FileUpload ID="FileUpload" runat="server" Filter="ImagesOnly" />

        <!-- file upload ends -->

        <div class="stacked-input-control"></div><!-- placeholder for label-side H2 -->
        <div class="stacked-input-control"><asp:TextBox runat="server" ID="TextBank" />&#8203;<br/></div>
        <div class="stacked-input-control"><asp:TextBox runat="server" ID="TextClearing" />&#8203;<br/></div>
        <div class="stacked-input-control"><asp:TextBox runat="server" ID="TextAccount" />&nbsp;<br/></div>
        <asp:Button ID="ButtonRequest" runat="server" CssClass="buttonAccentColor NoInputFocus" OnClientClick="return validateFields();" OnClick="ButtonRequest_Click" Text="Request"/>
    </div>
    <div class="entryLabels">
        <asp:Label runat="server" ID="LabelAmount" /><br/>
        <asp:Label runat="server" ID="LabelPurpose" /><br/>
        <asp:Label runat="server" ID="LabelBudget" /><br/>
        <asp:Repeater ID="RepeaterTagLabels" runat="server"><ItemTemplate><%# Eval("TagSetLocalizedName") %><br/></ItemTemplate></asp:Repeater>
        <h2><asp:Label runat="server" ID="LabelHeaderImageFiles" /></h2>
        <asp:Label runat="server" ID="LabelImageFiles" /><br/>
        <h2><asp:Label runat="server" ID="LabelHeaderBankDetails" /></h2>
        <asp:Label runat="server" ID="LabelBankName" /><br/>
        <asp:Label runat="server" ID="LabelBankClearing" /><br/>
        <asp:Label runat="server" ID="LabelBankAccount" />
    </div>
    <div style="clear:both"></div>
</asp:Content>



<asp:Content ID="Content6" ContentPlaceHolderID="PlaceHolderSide" Runat="Server">
</asp:Content>


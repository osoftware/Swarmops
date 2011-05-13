<%@ Page Language="C#" MasterPageFile="~/PirateWeb-v4.master" AutoEventWireup="true" CodeFile="ViewResultSheet.aspx.cs" Inherits="Pages_v4_ViewResultSheet" Title="View Result Sheet - PirateWeb" %>
<%@ Register Src="~/Controls/v4/OrganizationTree.ascx" TagName="OrganizationTree" TagPrefix="pw4" %>
<%@ Register Src="~/Controls/v4/GeographyTree.ascx" TagName="GeographyTree" TagPrefix="pw4" %>
<%@ Register Src="~/Controls/v4/OrganizationTreeDropDown.ascx" TagName="OrganizationTreeDropDown" TagPrefix="pw4" %>
<%@ Register Src="~/Controls/v4/GeographyTreeDropDown.ascx" TagName="GeographyTreeDropDown" TagPrefix="pw4" %>
<%@ Register Src="~/Controls/v4/PageTitle.ascx" TagName="PageTitle" TagPrefix="pw4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">

<style type="text/css"> 
 .RadGrid td {padding:0}
</style> 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" Runat="Server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>
   <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
        function ShowAccountForm(id, rowIndex)
        {
            var grid = $find("<%=GridBudgetAccounts.ClientID%>");
            
            var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
            grid.get_masterTableView().selectItem(rowControl, true);
                    
            window.radopen("PopupEditAccount.aspx?FinancialAccountId=" + id, "BudgetForm");
            return false;
        }
        
        
        function ToggleLineMode(id)
        {
            ToggleBothModes('LastYear' + id);
            ToggleBothModes('Ytd' + id);
            ToggleBothModes('Q1' + id);
            ToggleBothModes('Q2' + id);
            ToggleBothModes('Q3' + id);
            ToggleBothModes('Q4' + id);
        }
        
        function ToggleBothModes (id)
        {
            ToggleSpanVisibility('GridSpanCollapsed' + id);
            ToggleSpanVisibility('GridSpanExpanded' + id);
        }
        
        function ToggleSpanVisibility (id)
        {
            var span = $get(id);

            if (span.style.display == 'none')
            {
                span.style.display = 'inline';
            }
            else
            {
                span.style.display = 'none';
            }
        }
        
      
        function refreshGrid(arg)
        {
         if(!arg)
         {
         $find("<%=RadAjaxManager1.ClientID%>").ajaxRequest("Rebind");            
            }
            else
            {
         $find("<%=RadAjaxManager1.ClientID%>").ajaxRequest("RebindAndNavigate");            
            }
        }
        </script>
    </telerik:RadCodeBlock>

    <pw4:PageTitle Icon="chart_bar.png" Title="View Result Sheet" Description="View status of result accounts" runat="server" ID="PageTitle" />
    <asp:UpdatePanel ID="UpdatePanel" runat="server" >
    <ContentTemplate>
    <div class="DivMainContent">
    <div class="DivGroupBox">
    <span class="DivGroupBoxTitle">Select Organization and Budget Year</span><br />
    <div class="DivGroupBoxContents">
    Only <b>Piratpartiet SE</b> and <b>2010</b> for now.
    </div>
    </div>
    <div class="DivGroupBox">
    <span class="DivGroupBoxTitle"><asp:Label ID="LabelOrganizationYearTitle" runat="server" Text="Piratpartiet SE result sheet for 2010" /></span><br />
    <div class="DivGroupBoxContents">
    <telerik:RadGrid ID="GridBudgetAccounts" runat="server" AllowMultiRowSelection="False" 
            AutoGenerateColumns="False" GridLines="None" Skin="Default"
            OnItemCreated="GridBudgetAccounts_ItemCreated" OnColumnCreated="GridBudgetAccounts_ColumnCreated"
            OnItemDataBound="GridBudgetAccounts_ItemDataBound" OnItemCommand="GridBudgetAccounts_ItemCommand">
        <HeaderContextMenu>
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </HeaderContextMenu>

        <MasterTableView DataKeyNames="Identity,ParentFinancialAccountId,Name" HierarchyDefaultExpanded="false" HierarchyLoadMode="Client" AllowSorting="true" >
            <SelfHierarchySettings ParentKeyName="ParentFinancialAccountId" KeyName="Identity" />
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Account" DataField="Name" UniqueName="Name">
                    <ItemTemplate>
                        <div style="width:250px;"><asp:Label ID="LabelAccountName" runat="server" Visible="false"/></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn HeaderText="AccountId" DataField="Identity" Visible="false" />
                <telerik:GridBoundColumn HeaderText="ParentAccountId" DataField="ParentFinancialAccountId" Visible="false" />
                <telerik:GridTemplateColumn HeaderText="Last Year" HeaderStyle-HorizontalAlign="Right" UniqueName="ColumnBudgetLastYear" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div style="width:75px;"><asp:Literal ID="LiteralLastYear" runat="server"/></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Q1" HeaderStyle-HorizontalAlign="Right"
                    UniqueName="ColumnResultQ1" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div style="width:75px;"><asp:Literal ID="LiteralQuarter1" runat="server" Text="[TBI]" /></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Q2" HeaderStyle-HorizontalAlign="Right"
                    UniqueName="ColumnResultQ2" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div style="width:75px;"><asp:Literal ID="LiteralQuarter2" runat="server" Text="[TBI]" /></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Q3" HeaderStyle-HorizontalAlign="Right"
                    UniqueName="ColumnResultQ3" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div style="width:75px;"><asp:Literal ID="LiteralQuarter3" runat="server" Text="[TBI]" /></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Q4" HeaderStyle-HorizontalAlign="Right"
                    UniqueName="ColumnResultQ4" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div style="width:75px;"><asp:Literal ID="LiteralQuarter4" runat="server" Text="[TBI]" /></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="YTD" HeaderStyle-HorizontalAlign="Right"
                    UniqueName="ColumnOutbound" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div style="width:75px;"><asp:Literal ID="LiteralThisYear" runat="server" /></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridTemplateColumn UniqueName="ManageColumn" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div style="width:100px;"><asp:HyperLink ID="ManageLink" runat="server" Text="Edit account..."></asp:HyperLink></div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
            </Columns>
            
        </MasterTableView>
        <ClientSettings AllowExpandCollapse="true">
            <Selecting AllowRowSelect="true" />
        </ClientSettings>
        <FilterMenu>
            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </FilterMenu>
    </telerik:RadGrid>
    

    </div>
    </div>
    <asp:Panel ID="PanelCreateTransaction" runat="server" Visible="false">
    <div class="DivGroupBox">
    <span class="DivGroupBoxTitle">Create Transaction Manually</span><br />
    <div class="DivGroupBoxContents">
    
    Create a new transaction with the following base data:<br />
    <div style="float:left">Date<br />Description&nbsp;&nbsp;<br />Account<br />Amount<br />
    </div>
    
    <div style="float:left">
    
    <telerik:RadDatePicker ID="DateCreate" runat="server" />&nbsp;<br />
    <asp:TextBox ID="TextDescriptionCreate" runat="server" />&nbsp;<br />
    <asp:DropDownList ID="DropAccountsCreate" runat="server" /><b><asp:Label ID="LabelAccountCreate" runat="server" Visible="false" /></b>&nbsp;<br />
    <asp:TextBox ID="TextAmountCreate" runat="server" Text="0,00" />&nbsp;<br />
    <asp:Button ID="ButtonCreateTransaction" runat="server" Text="Create" />&nbsp;<br />
    </div>
    <div style="clear:both">A transaction edit window will open where you can balance the transaction against other accounts.</div>
    
    </div>
    </div>
    </asp:Panel>
    </div>

  
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Web20">
        <Windows>
            <telerik:RadWindow VisibleStatusbar="false" Skin="Web20" ID="BudgetForm" runat="server" Title="Editing Budget" Height="400px"
                        Width="500px" ReloadOnShow="true" Modal="true" Behaviors="Close" />
        </Windows>
    </telerik:RadWindowManager>
    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridBudgetAccounts" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="GridBudgetAccounts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridBudgetAccounts" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
 
    </ContentTemplate>
    <Triggers>
    </Triggers>
    </asp:UpdatePanel>

    <!-- <asp:Label ID="LabelTest" runat="server" /> -->

</asp:Content>


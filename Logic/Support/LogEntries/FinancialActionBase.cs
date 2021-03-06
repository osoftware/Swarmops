﻿using System;

namespace Swarmops.Logic.Support.LogEntries
{
    [Serializable]
    public class FinancialActionBase : LogEntryBase<FinancialActionBase>
    {
        public int FinancialAccountId { get; set; }
        public string FinancialAccountName { get; set; }
        public int ActingPersonId { get; set; }
        public int BeneficiaryPersonId { get; set; }
        public int OrganizationId { get; set; }
        public double Amount { get; set; }
        public double Vat { get; set; }
        public string Currency { get; set; }
        public string Description { get; set; }
        public int OwnerPersonId { get; set; }
        public string OwnerPersonName { get; set; }
        /// <summary>
        /// Always in UTC
        /// </summary>
        public DateTime DateTime { get; set; }
    }
}
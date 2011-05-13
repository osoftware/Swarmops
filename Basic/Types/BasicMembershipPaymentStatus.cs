using System;
using System.Collections.Generic;
using System.Text;
using Activizr.Basic.Enums;

namespace Activizr.Basic.Types
{
    public class BasicMembershipPaymentStatus
    {
        public BasicMembershipPaymentStatus (int membershipId,MembershipPaymentStatus status, DateTime statusDateTime)
        {
            this.MembershipId = membershipId ;
            this.Status = status;
            this.StatusDateTime = statusDateTime;
        }

        public int MembershipId  { get; protected set; }
        public MembershipPaymentStatus Status { get; set; }
        public DateTime StatusDateTime { get; set; }
    }
}

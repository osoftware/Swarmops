using System.Collections.Generic;

using Activizr.Basic.Types;

namespace Activizr.Logic.Financial
{
    public class FinancialAccountRows : List<FinancialAccountRow>
    {
        public static FinancialAccountRows FromArray (BasicFinancialAccountRow[] array)
        {
            var result = new FinancialAccountRows {Capacity = (array.Length*11/10)};

            foreach (BasicFinancialAccountRow basic in array)
            {
                result.Add (FinancialAccountRow.FromBasic (basic));
            }

            return result;
        }
    }
}
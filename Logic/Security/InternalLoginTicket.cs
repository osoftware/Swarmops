using System;
using System.Collections.Generic;
using System.Text;

namespace Activizr.Logic.Security
{
    public class InternalLoginTicket
    {
        public DateTime created = DateTime.MinValue;
        public int validatedUserID = -1;
    }

}

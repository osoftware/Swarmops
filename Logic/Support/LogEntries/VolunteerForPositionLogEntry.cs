﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Swarmops.Logic.Swarm;

namespace Swarmops.Logic.Support.LogEntries
{
    [Serializable]
    public class VolunteerForPositionLogEntry: PositionActionBase
    {
        public VolunteerForPositionLogEntry (Person person, Position position)
        {
            this.ActingPersonId = this.ConcernedPersonId = person.Identity;
            this.PositionId = position.Identity;
            this.DateTime = DateTime.UtcNow;
        }
    }
}

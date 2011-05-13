using System;
using System.Collections.Generic;
using System.Text;
using Activizr.Logic.Security;
using Activizr.Logic.Structure;
using Activizr.Basic.Types;
using Activizr.Database;

namespace Activizr.Logic.Governance
{
    public class MeetingElectionVote: BasicInternalPollVote
    {
        private MeetingElectionVote (BasicInternalPollVote basic): base (basic)
        {
            // empty private ctor            
        }

        static public MeetingElectionVote FromBasic (BasicInternalPollVote basic)
        {
            return new MeetingElectionVote(basic);
        }

        static public MeetingElectionVote FromIdentity (int internalPollVoteId)
        {
            return FromBasic(PirateDb.GetDatabase().GetInternalPollVote(internalPollVoteId));
        }

        static public MeetingElectionVote FromVerificationCode (string verificationCode)
        {
            return FromBasic(PirateDb.GetDatabase().GetInternalPollVote(verificationCode));
        }

        static public MeetingElectionVote Create (MeetingElection poll, Geography voteGeography)
        {
            return
                FromIdentity(PirateDb.GetDatabase().CreateInternalPollVote(poll.Identity, voteGeography.Identity,
                                                                           Authentication.
                                                                               CreateRandomPassword(12)));
        }

        public void AddDetail (int position, MeetingElectionCandidate candidate)
        {
            PirateDb.GetDatabase().CreateInternalPollVoteDetail(this.Identity, candidate.Identity, position);            
        }

        public void Clear()
        {
            PirateDb.GetDatabase().ClearInternalPollVote(this.Identity);
        }

        public int[] SelectedCandidateIdsInOrder
        {
            get { return PirateDb.GetDatabase().GetInternalPollVoteDetails(this.Identity); }
        }

        /*
        public MeetingElectionCandidates Candidates
        {
            get { return MeetingElectionCandidates.FromIdentities(SelectedCandidateIdsInOrder); }
        }*/
    }
}
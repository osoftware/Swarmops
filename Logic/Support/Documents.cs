using System;
using System.Collections.Generic;
using System.Linq;
using Swarmops.Basic.Types;
using Swarmops.Basic.Types.Structure;
using Swarmops.Common.Interfaces;
using Swarmops.Database;
using Swarmops.Logic.Swarm;

namespace Swarmops.Logic.Support
{
    public class Documents : PluralBase<Documents,Document,BasicDocument>
    {
        private IHasIdentity sourceObject;

        public static Documents ForObject (IHasIdentity identifiableObject)
        {
            Documents newInstance =
                FromArray (
                    SwarmDb.GetDatabaseForReading().GetDocumentsForForeignObject (
                        Document.GetDocumentTypeForObject (identifiableObject), identifiableObject.Identity));

            newInstance.sourceObject = identifiableObject;

            return newInstance;
        }

        public static Documents GetAll()
        {
            return FromArray(SwarmDb.GetDatabaseForReading().GetAllDocuments());
        }


        public Document Add (string serverFileName, string clientFileName, Int64 fileSize,
            string description, Person uploader)
        {
            // This is kind of experimental. Is it a good idea to be able to write
            // Expenses.Documents.Add (...), or is it just stupid?


            if (this.sourceObject == null)
            {
                throw new InvalidOperationException (
                    "Cannot add documents to a Documents instance that was not created from an object.");
            }

            Document newDocument =
                Document.Create (serverFileName, clientFileName, fileSize, description,
                    this.sourceObject, uploader);

            base.Add (newDocument);

            return newDocument;
        }


        public static Documents RecentFromDescription (string description)
        {
            return FromArray (SwarmDb.GetDatabaseForReading().GetDocumentsRecentByDescription (description));
        }


        public void SetForeignObjectForAll (IHasIdentity foreignObject)
        {
            foreach (Document doc in this)
            {
                doc.SetForeignObject (foreignObject);
            }
        }

        public Documents WhereNotAssociated
        {
            get
            {
                Documents result = new Documents();
                result.AddRange(this.Where(doc => doc.ForeignId == 0));

                return result;
            }
        }
    }
}
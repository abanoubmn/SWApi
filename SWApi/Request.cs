//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SWApi
{
    using System;
    using System.Collections.Generic;
    
    public partial class Request
    {
        public System.Guid RequestID { get; set; }
        public System.Guid Requested { get; set; }
        public System.Guid Requester { get; set; }
    
        public virtual Account Account { get; set; }
        public virtual Account Account1 { get; set; }
    }
}
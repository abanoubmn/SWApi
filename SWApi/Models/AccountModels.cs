using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SWApi.Models
{
    public class LoginViewModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }
    }

    public class PostViewModel
    {
        [Required]
        public string PostContent { get; set; }
        [Required]
        public Guid AccountID { get; set; }
        
        public DateTime DateCreated { get; set; }
    }

    public class CommentViewModel
    {
        [Required]
        public int PostID { get; set; }
        [Required]
        public string CommentContent { get; set; }
        [Required]
        public Guid CommenterID { get; set; }
    }
}
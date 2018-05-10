using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SWApi.Models;
using System.Data.Entity.Core.Objects;

namespace SWApi.Controllers
{
    public class AccountController : ApiController
    {
        private SocialWebsiteEntities db = new SocialWebsiteEntities();

        [HttpPost]
        public Object Login(LoginViewModel model)
        {
            string password = Encryptor.MD5Hash(model.Password);
            Account account = db.Accounts.FirstOrDefault(a => a.UserName == model.UserName && a.Password == password);
            if (account != null)
            {
                return new
                {
                    FullName = account.FullName,
                    UserName = account.UserName,
                    AccountID = account.ID.ToString(),
                    ProfilePicture = account.ProfilePicture.ImageURL
                };
            }
            else
            {
                return ("Username or Password is incorrect!");
            }

        }

        public ObjectResult<GetAllPosts_Result> GetPosts(string id)
        {
            return db.GetAllPosts(Guid.Parse(id));
        }

        public ObjectResult<GetComments_Result> GetComments(int id)
        {
            return db.GetComments(id);
        }

        public ObjectResult<GetProfileData_Result> GetProfileData(string id)
        {
            return db.GetProfileData(Guid.Parse(id));
        }

        public Object GetAccountData(string id)
        {
            Account acc = db.Accounts.Find(Guid.Parse(id));
            return new
            {
                FullName = acc.FullName,
                ProfilePicture = acc.ProfilePicture.ImageURL
            };
        }

        [HttpGet]
        public ObjectResult<SearchAccounts_Result> SearchAccounts(string name, string id)
        {
            return db.SearchAccounts(name, Guid.Parse(id));
        }

        [HttpPost]
        public void CreatePost(PostViewModel post)
        {
            if (post.PostContent != null && post.AccountID != null)
            {
                Post newPost = new Post()
                {
                    AccountID = post.AccountID,
                    PostContent = post.PostContent,
                    DateCreated = DateTime.Now
                };
                db.Posts.Add(newPost);
                db.SaveChanges();
            }
        }

        [HttpPost]
        public void CreateComment(CommentViewModel comment)
        {
            if (comment.CommentContent != null && comment.CommenterID != null && comment.PostID != 0)
            {
                Comment newComment = new Comment()
                {
                    PostID = comment.PostID,
                    CommenterID = comment.CommenterID,
                    CommentContent = comment.CommentContent
                };
                db.Comments.Add(newComment);
                db.SaveChanges();
            }
        }

        public ObjectResult<GetFriendList_Result> GetFriendList(string id)
        {
            return db.GetFriendList(Guid.Parse(id));
        }

        public ObjectResult<GetLikers_Result> GetLikers(int id)
        {
            return db.GetLikers(id);
        }

        public String LikePost(int postId, string accountId)
        {
            int i = 0;
            try
            {
                i = db.InsertLike(Guid.Parse(accountId), postId);
            }
            catch (Exception)
            {

            }
            if (i == -1)
            {
                return "succeed";
            }
            else
            {
                return "failed";
            }
        }

        public String UnlikePost(int postId, string accountId)
        {
            int i = 0;
            try
            {
                i = db.DeleteLike(Guid.Parse(accountId), postId);
            }
            catch (Exception)
            {

            }
            if (i == -1)
            {
                return ("succeed");
            }
            else
            {
                return ("failed");
            }
        }

        public String LikeCount(int postId)
        {
            int count = (int)db.LikesCount(postId).First();
            return (count + "");
        }

        public IEnumerable<Request> FriendRequests(string id)
        {
            Guid accountId = Guid.Parse(id);
            var requests = db.Requests.Where(a => a.Requested == accountId) as IEnumerable<Request>;
            return requests;
        }

        public String SendFriendRequest(string accountId, string RequestedUsername)
        {

            var RequestedID = db.Accounts.FirstOrDefault(a => a.UserName == RequestedUsername).ID;
            if (db.Friends.Find(accountId, RequestedID) == null && db.Friends.Find(RequestedID, accountId) == null)
            {
                string result = "";
                // to prevent two way requests
                if (db.Requests.Find(accountId, RequestedID) == null && db.Requests.Find(RequestedID, accountId) == null)
                {

                    try
                    {
                        SWApi.Request NewRequest = new Request()
                        {
                            Requested = RequestedID,
                            Requester = Guid.Parse(accountId),
                            RequestID = Guid.NewGuid()
                        };
                        db.Requests.Add(NewRequest);
                        db.SaveChanges();

                        result = ("succeeded");
                    }
                    catch (Exception ex)
                    {
                        result = ("failed");
                        throw ex;
                    }

                }
                return (result);
            }
            else
            {
                return "failed";
            }
        }

        public String AcceptFriendRequest(string username, string accountId)
        {
            int i = 0;
            try
            {
                i = db.AcceptRequest(Guid.Parse(accountId), username);
            }
            catch (Exception)
            {

                throw;
            }
            if (i == -1)
            {
                return ("succeed");
            }
            else
            {
                return ("failed");
            }
        }

        public String RejectFriendRequest(string username, string accountId)
        {

            int i = 0;
            try
            {
                i = db.RejectRequest(Guid.Parse(accountId), username);
            }
            catch (Exception)
            {

                throw;
            }
            if (i == -1)
            {
                return ("succeed");
            }
            else
            {
                return ("failed");
            }
        }

        [HttpPost]
        public String DeletePost(int postId, string accountId)
        {
            int i = 0;
            try
            {
                i = db.DeletePost(postId, Guid.Parse(accountId));
            }
            catch (Exception ex)
            {

            }
            if (i == -1)
            {
                return ("succeed");
            }
            else
            {
                return ("failed");
            }
        }

        [HttpPost]
        public String EditPost(Post post)
        {
            int i = 0;
            try
            {
                i = db.EditPost(post.PostID, post.AccountID, post.PostContent);
            }
            catch (Exception)
            {

                throw;
            }
            if (i == -1)
            {
                return ("succeed");
            }
            else
            {
                return ("failed");
            }
        }
    }
}

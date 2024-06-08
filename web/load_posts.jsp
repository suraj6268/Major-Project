<%@page import="com.presional.entities.user"%>
<%@page import="com.presional.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.presional.entities.Post"%>
<%@page import="com.presional.helper.ConnectionProvider"%>
<%@page import="com.presional.dao.PostDao"%>

<div class="row">
    <%
        user uuu = (user)session.getAttribute("currentUser");
        
        Thread.sleep(1000);
        PostDao d = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        }
        else{
            posts = d.getPostByCatId(cid);
        }
        
        if(posts.size() == 0)
        {
            out.println("<h3 class='display-3 text-center'>No Post in this cotegory..</h3>");
            return ;
        }
        
        for (Post p : posts) {
    %>

    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%= p.getpTitle()%></b>
                <p><%= p.getpContent()%></p>
                
            </div>
                <div class="card-footer primary-backgroung text-center">
                    
                    <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    %>
                    
                    <a href="#!" onclick="doLike(<%= p.getPid() %>,<%= uuu.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"><span class="like-counter"><%= ld.countLikeOnPost(p.getPid()) %></span></i></a>
                    <a href="show_blog_page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm">Read More...</a>
                    <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"><span>20</span></i></a>
                </div>
        </div>

    </div>


    <%
        }


    %>
</div>
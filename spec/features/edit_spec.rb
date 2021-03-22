<%= erb :"common/headerB" %>
<div class="background" id="statement">
  <!--Our Program-->
  <div class="full">
    <div class="title">Login</div> <!--Main page Title-->  

      <form method="post" action="/login">

        <% unless @error.nil? %>
        <p><strong class="error"><%= @error %></strong></p>
        <% end %>

        <p>Username: <br /><input type="text" name="username" id="username" for="username" value="<%= @mentees.username %>"/></p>
        <% if @mentees.errors.include?("username") %>
          <% @mentees.errors["username"].each do |error| %>
            <p class="error"><strong>Username <%= error %></strong></p>
          <% end %>
        <% end %>

        <p>Password: <br /><input type="password" name="password" id="password" for="password"/></p>
        <% if @mentees.errors.include?("password") %>
          <% @mentees.errors["password"].each do |error| %>
            <p class="error"><strong>Password <%= error %></strong></p>
          <% end %>
        <% end %>
        
        <p><input type="submit" value="Submit"></p>
        
        <p>Dont have an account?<br>
        <a href="/SignUpChoices" class="underline">Sign Up</a>
        </p>

      </form>
  </div>
</div>

<%= erb :"common/footer" %>


<!--PAGE USED TO LOGIN-->
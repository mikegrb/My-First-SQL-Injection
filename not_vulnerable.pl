#!/usr/bin/env perl

use Mojolicious::Lite;
use DBI;

my $db = DBI->connect('dbi:SQLite:injection.db');

get  '/'      => sub { shift->render('index') };
post '/login' => sub {
    my $c = shift;

    my $user = $c->param('username');
    my $pass = $c->param('password');

    my ($name, $is_admin) = $db->selectrow_array(q{
        SELECT name, is_admin FROM Users
        WHERE username = ? AND password = ?
    }, undef, $user, $pass);

    if ($name) {
        $c->stash(name => $name);
        $c->stash(is_admin => $is_admin);
    }
    else {
        $c->render('login_error');
    }
};

app->start;

__DATA__
@@ index.html.ep
<html>
<head><title>My First SQL Injection</title></head>
<body>
<h1>My First SQL Injection</h1>
<form action="/login" method="POST">
    Username: <input type="text" name="username"><br>
    Password: <input type="password" name="password"><br>
    <input type="submit" value="Log In!">
</form>
</body>
</html>

@@ login.html.ep
<html>
<head><title>My First SQL Injection</title></head>
<body>
<h1>Hello, <%= $name %>!</h1>

% if ($is_admin) {
You are an admin.
% } else {
You are a noob user.
% }
</body>
</html>

@@ login_error.html.ep
<html>
<head><title>My First SQL Injection</title></head>
<body>
<h1>My First SQL Injection</h1>
<h3 style="color:red">Error, please try again</h3>
<form action="/login" method="POST">
    Username: <input type="text" name="username"><br>
    Password: <input type="password" name="password"><br>
    <input type="submit" value="Log In!">
</form>
</body>
</html>


%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
if(~ $REQUEST_METHOD POST) {
    rm -r etc/users/$user/*
    cp -r etc/users/template/* etc/users/$user/
}
%}

<main>
    <h1>Venture Capitalist Simulator 2022</h1>
    <h2>A Gelato Labs production<br>for Ludum Dare 51</h2>
    <h3>"Every 10 seconds"</h3>
    <button onclick="window.navigation.navigate('/invest')">Play</button>
%   if(! ~ $#user 0 && ~ $REQUEST_METHOD GET) {
        <form action="/" method="POST">
            <button onclick="window.navigation.navigate('/invest')">Reset game</button>
        </form>
%   }
</main>

<style>
    html, body {
        height: 100%;
        background: linear-gradient(180deg, #00f, #000);
        overflow-y: hidden;
    }

    main {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        text-align: center;
        color: #ff0;
    }

    form {
        display: inline-block;
    }
</style>

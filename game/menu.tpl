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
%   if(! ~ $#user 0 &&
%      test -f etc/users/$user/difficulty &&
%      ~ $REQUEST_METHOD GET) {
        <button onclick="document.getElementById('click').play(); window.location.href = 'invest'">Continue</button>
        <form action="" method="POST">
            <button onclick="document.getElementById('click').play()">Reset game</button>
        </form>
%   }
%   if not {
        <form action="/intro" method="POST">
            <div class="field-row">Difficulty:</div>
            <div class="field-row">
                <input id="ld" type="radio" name="difficulty" value="ld" checked>
                <label for="ld">Ludum Dare: 10 second timer</label>
            </div>
            <div class="field-row">
                <input id="easy" type="radio" name="difficulty" value="easy">
                <label for="easy">Easy baby mode: 30 second timer</label>
            </div>
            <div class="field-row">
                <input id="plot" type="radio" name="difficulty" value="plot">
                <label for="plot">Here for the plot: no timer</label>
            </div><br>
            <button onclick="parent.music(); document.getElementById('click').play()">Play</button>
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
	max-height: 100vh;
	overflow-y: auto;
        text-align: center;
        color: #ff0;
    }

    form {
        display: inline-block;
    }
</style>

<audio id="click" src="/snd/click.ogg" />

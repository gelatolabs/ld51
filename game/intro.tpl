%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
if(~ $"p_difficulty ld)
    echo ld > etc/users/$user/difficulty
if not if(~ $"p_difficulty easy)
    echo easy > etc/users/$user/difficulty
if not if(~ $"p_difficulty plot)
    echo plot > etc/users/$user/difficulty
%}

<main>
    <h1>Welcome</h1>
    <p>Greetings friend,<br><br>
       Welcome to Venture Capitalist Simulator 2022.  Before we begin, please understand 
that many hours of blood sweat and tears were dedicated to this work of art.  Rest assured 
that no animals were harmed in the creation of this software, although Mr. Pickles had a
close call and is making excellent progress with improved psych evals.<br><br>
       You are a bloodsucking investor looking to capitalize on those poor vulnerable
souls that are desperate for money and are waiting to have their precious equity taken 
right before their eyes.  Your task is simple - MAXIMIZE PROFIT.  This is your only
goal and sole purpose, anything else would be uncivilized.  When presented with a choice
be quick and firm with your decision - as you only have 10 seconds to determine your fate.
Good luck, and may the most ruthless investor win!<br><br>
       Sincerely,<br>
       The Gelato Productions International Universal Global Executive Team</p>
    <button onclick="document.getElementById('click').play(); window.location.href = 'invest'">Okay</button>

    <h2>Disclaimer</h2>
    <p>Gelato Labs generated startup slide deck text in part with GPT-3, OpenAI’s large-scale language-generation model. Upon generating draft language, we reviewed, edited, and revised the language to our own liking and take ultimate responsibility for the content of this publication. Additionally, startup product images were generated using DALL·E, OpenAI’s image-generation model.</p>
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
        color: #ff0;
    }

    p {
        font-size: 150%;
    }
</style>

<audio id="click" src="/snd/click.ogg" />

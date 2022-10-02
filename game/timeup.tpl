%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
funds=`{cat etc/users/$user/funds}
fine=`{int `{x $funds 0.3}}
funds=`{- $funds $fine}
echo $funds > etc/users/$user/funds
%}

<main>
    <h1>Too slow!</h1>
    <h3>You can't afford to sit around in this economy! You've been fined $%($fine%) by the SEC for wasting everyone's time.</h3>
    <h3>Pro tip: startups put lots of useless filler in their slides. Save time by just skimming the History slide.</h3>
    <button onclick="window.location.href = 'invest'">Sorry</button>
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
</style>

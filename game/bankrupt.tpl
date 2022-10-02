%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
investments=`{grep -L '^0$' etc/users/$user/positions/*/investment | wc -l}
%}

% if (gt $investments 0) {
      <main>
          <h1>Bankrupt!</h1>
          <h3>Your stocks will be automatically liquidated.</h3>
          <form action="invest" method="POST">
%             for (startup in etc/users/$user/positions/*) {
                  <input type="hidden" name="%(`{basename $startup}%)" value="sell">
%             }
              <button>Continue</button>
          </form>
      </main>
% }
% if not {
      <main>
          <h1>Bankrupt!</h1>
          <h3>Game over.</h3>
          <form action="menu" method="POST">
              <button>Menu</button>
          </form>
      </main>
% }

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

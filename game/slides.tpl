% startup=site/data/startups/$q_startup

<main class="theme%(`{shuf -i 1-5 -n 1}%)">
    <div class="slide logo">
        <h1>%($q_name%)</h1>
    </div>
    <div class="slide product">
        <h2>Product</h2>
        <img src="/img/products/%($q_startup%)/%(`{shuf -i 1-4 -n 1}%).png" />
        <p>%(`{cat $startup/idea}%)</p>
    </div>
    <div class="slide vision">
        <h2>Vision</h2>
        <p>%(`{fortune $startup/vision}%)</p>
    </div>
    <div class="slide">
        <h2>History</h2>
%       if(~ $q_quality good) {
            <ul>%(`{fortune $startup/good/history}%)</ul>
%       }
%       if not {
            <ul>%(`{fortune $startup/bad/history}%)</ul>
%       }
    </div>
    <div class="slide financials">
        <h2>Financials?</h2>
        <img src="/img/graphs/%(`{shuf -i 1-13 -n 1}%).png" />
    </div>
    <div class="slide end">
        <p>%(`{fortune site/data/thanks}%)</p>
    </div>
</main>

<style>
    body {
        overflow-x: hidden;
    }

    main {
        position: absolute;
        top: 0;
        left: 0;
        background-color: silver;
    }

    .slide {
        width: calc(100vw - 16px);
        height: calc((100vw - 16px) * 0.75);
        margin: 0 0 8px 0;
    }
    .slide:last-child {
        margin-bottom: 0;
    }

    h1, h2, h3, h4, h5, h6, p {
        margin: 0 2vw;
    }

    h1 { font-size: 10vw; }
    h2 { font-size: 9vw; }
    h3 { font-size: 8vw; }
    h4 { font-size: 7vw; }
    h5 { font-size: 6vw; }
    h6 { font-size: 5vw; }
    p, li { font-size: 4vw; }

    h2 {
        text-align: center;
    }

    .theme1 .slide {
        background: #000;
        color: #fff;
        font-family: sans-serif;
    }
    .theme2 .slide {
        background: linear-gradient(120deg, #00f260, #0575e6);
        color: #eee;
        font-family: "Trebuchet MS", sans-serif;
    }
    .theme3 .slide {
        background-color: #ffc7fb;
        background: linear-gradient(135deg, #a3a6ff55 25%, transparent 25%) -10px 0/ 20px 20px, linear-gradient(225deg, #a3a6ff 25%, transparent 25%) -10px 0/ 20px 20px, linear-gradient(315deg, #a3a6ff55 25%, transparent 25%) 0px 0/ 20px 20px, linear-gradient(45deg, #a3a6ff 25%, #ffc7fb 25%) 0px 0/ 20px 20px;
        color: #00f;
        font-family: "Comic Sans MS", "Chalkboard SE", "Comic Neue", cursive, sans-serif;
    }
    .theme4 .slide {
        background: #00f;
        color: #ff0;
        font-family: "Comic Sans MS", "Chalkboard SE", "Comic Neue", cursive, sans-serif;
    }
    .theme5 .slide {
        background: #fff;
        color: #000;
        font-family: "Courier New", Courier, monospace, serif;
    }

    .slide.logo {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
    }

    .slide.vision {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        background: url("https://picsum.photos/800/600?random=%($q_quality%)&blur");
        background-size: cover;
        background-position: center;
    }
    .slide.vision h2, .slide.vision p {
        color: #fff;
        text-shadow: 0 0 0.25vw #000, 0 0 0.5vw #000, 0 0 1vw #000, 0 0 2vw #000;
    }
    .slide.vision p {
        font-weight: bold;
    }

    .slide.product {
        text-align: center;
    }
    .slide.product img {
        width: 55%;
    }

    .slide.financials {
        text-align: center;
    }
    .slide.financials img {
        height: 80%;
        max-width: 100%;
        object-fit: contain;
    }

    .slide.end {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        background: #000;
        color: #fff;
    }
</style>

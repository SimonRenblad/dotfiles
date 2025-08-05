{ }:
{
  enable = true;
  settings = {
    theme = {
      background-color = "232 23 18";
      contrast-multiplier = 1.2;
      primary-color = "220 83 75";
      positive-color = "105 48 72";
      negative-color = "351 74 73";
    };
    server = {
      host = "localhost";
      port = 8080;
    };
    pages = [
      {
        name = "RSS";
        columns = [
          {
            size = "full";
            widgets = [
              {
                type = "rss";
                style = "detailed-list";
                collapse-after = 50;
                cache = "12h";
                feeds = [
                  {
                    url = "https://selfh.st/rss/";
                  }
                  {
                    url = "https://www.phoronix.com/rss.php";
                  }
                  {
                    url = "https://www.cnx-software.com/feed/";
                  }
                  {
                    url = "https://hforsten.com/feeds/all.atom.xml";
                  }
                  {
                    url = "https://jwt625.github.io/feed.xml";
                  }
                  {
                    url = "https://chipsandcheese.com/feed";
                  }
                ];
              }
            ];
          }
        ];
      }
    ];
  };
}

{ }:
{
  enable = true;
  settings = {
    theme = "autumn_night_transparent";
    editor.cursor-shape = {
      normal = "block";
      insert = "bar";
      select = "underline";
    };
    editor.lsp.display-messages = true;
    editor.lsp.display-inlay-hints = true;
  };
  languages = {
    language = [
      {
        name = "nix";
        auto-format = false;
        formatter.command = "nixfmt";
      }
      {
        name = "c";
        auto-format = false;
        formatter.command = "clang-format";
      }
      {
        name = "python";
        auto-format = false;
        formatter = {
          command = "ruff";
          args = [
            "format"
            "-"
          ];
        };
        language-servers = [ "pylsp" ];
      }
      {
        name = "rust";
        auto-format = false;
        formatter = {
          command = "rustfmt";
        };
      }
      {
        name = "gas";
        auto-format = false;
      }
    ];
    language-server = {
      pylsp.config.pylsp.plugins = {
        ruff = {
          enabled = true;
          ignore = [ "F401" ];
          lineLength = 120;
        };
        pylint.enabled = true;
        flake8.enabled = true;
      };
      rust-analyzer.config = {
        cargo.features = "all";
      };
      nixd = {
        command = "nixd";
      };
    };
  };
  themes = {
    autumn_night_transparent = {
      "inherits" = "autumn_night";
      "type" = "gold";
    };
  };
}

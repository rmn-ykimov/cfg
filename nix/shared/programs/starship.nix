{ ... }:

# Base look comes from the pastel-powerline preset shipped with starship
# (https://starship.rs/presets/pastel-powerline). Only our own changes live here;
# Home Manager merges them on top of the preset.
{
  programs.starship = {
    enable = true;
    presets = [ "pastel-powerline" ];

    settings = {
      # Preset segments first; every other module we use follows on plain background,
      # then the prompt on a new line.
      format = builtins.concatStringsSep "" [
        "[](#9A348E)$os$username$hostname"
        "[](bg:#DA627D fg:#9A348E)$directory"
        "[](fg:#DA627D bg:#FCA17D)$git_branch$git_status"
        "[](fg:#FCA17D bg:#86BBD8)$c$elixir$elm$golang$gradle$haskell$java$julia$maven$nodejs$bun$nim$rust$scala"
        "[](fg:#86BBD8 bg:#06969A)$docker_context"
        "[](fg:#06969A bg:#33658A)$time"
        "[ ](fg:#33658A)"
        "$shlvl$singularity$kubernetes$vcsh$git_commit$git_state$git_metrics$hg_branch$package$buf"
        "$cmake$cobol$container$daml$dart$deno$dotnet$erlang$helm$kotlin$lua$ocaml$perl$php"
        "$pulumi$purescript$python$rlang$red$ruby$swift$terraform$vlang$vagrant$zig$crystal"
        "$nix_shell$conda$spack$memory_usage$aws$gcloud$openstack$azure$env_var$custom$sudo$cmd_duration"
        "$line_break$jobs$battery$status$shell$character"
      ];

      # Same segment colour as the user name.
      hostname = {
        ssh_only = false;
        style = "bg:#9A348E";
        format = "[$ssh_symbol$hostname ]($style)";
      };

      # Off by default in starship, on here.
      kubernetes.disabled = false;
      git_metrics.disabled = false;
      shell.disabled = false;
      memory_usage = {
        disabled = false;
        threshold = -1;
        format = "$symbol[$ram( | $swap)]($style) ";
      };
      package.format = "[$symbol$version]($style) ";

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };

      git_status = {
        ahead = "🏎💨$count";
        behind = "😰$count";
        conflicted = "🏳";
        deleted = "🗑";
        diverged = "😵";
        modified = "📝";
        renamed = "👅";
        staged = "[++($count)](green bg:#FCA17D)";
        stashed = "📦";
        untracked = "🤷";
        up_to_date = "✓";
      };

      nix_shell = {
        impure_msg = "[impure](bold red)";
        pure_msg = "[pure](bold green)";
      };

      cmd_duration = {
        format = "⏱ [$duration]($style) ";
      };
    };
  };
}

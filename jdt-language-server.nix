{ jdk, jdt-language-server, lombok, stdenv, ... }:

# This is a wrapped version of
# <https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/tools/jdt-language-server/default.nix>
# but with lombok support added.
jdt-language-server.overrideAttrs (oldAttrs: rec {
  buildInputs = [ jdk lombok ];
  installPhase =
    let
      # The application ships with config directories for linux and mac
      configDir = if stdenv.isDarwin then "config_mac" else "config_linux";
    in
    ''
      # Copy jars
      install -D -t $out/share/java/plugins/ plugins/*.jar
      # Copy config directories for linux and mac
      install -Dm 444 -t $out/share/config ${configDir}/*
      # Get latest version of launcher jar
      # e.g. org.eclipse.equinox.launcher_1.5.800.v20200727-1323.jar
      launcher="$(ls $out/share/java/plugins/org.eclipse.equinox.launcher_* | sort -V | tail -n1)"
      # The wrapper script will create a directory in the user's cache, copy in the config
      # files since this dir can't be read-only, and by default use this as the runtime dir.
      #
      # The following options are required as per the upstream documentation:
      #
      #   -Declipse.application=org.eclipse.jdt.ls.core.id1
      #   -Dosgi.bundles.defaultStartLevel=4
      #   -Declipse.product=org.eclipse.jdt.ls.core.product
      #   -noverify
      #   --add-modules=ALL-SYSTEM
      #   --add-opens java.base/java.util=ALL-UNNAMED
      #   --add-opens java.base/java.lang=ALL-UNNAMED
      #
      # The following options configure the server to run without writing logs to the nix store:
      #
      #   -Dosgi.sharedConfiguration.area.readOnly=true
      #   -Dosgi.checkConfiguration=true
      #   -Dosgi.configuration.cascaded=true
      #   -Dosgi.sharedConfiguration.area=$out/share/config
      #
      # Other options which the caller may change:
      #
      #   -Dlog.level:
      #     Log level.
      #     This can be overidden by setting JAVA_OPTS.
      #
      # The caller must specify the following:
      #
      #   -data:
      #     The application stores runtime data here. We set this to <cache-dir>/$PWD
      #     so that projects don't collide with each other.
      #     This can be overidden by specifying -configuration to the wrapper.
      #
      # Java options, such as -Xms and Xmx can be specified by setting JAVA_OPTS.
      #
      makeWrapper ${jdk}/bin/java $out/bin/jdt-language-server \
        --add-flags "-javaagent:${lombok}/share/java/lombok.jar" \
        --add-flags "-Declipse.application=org.eclipse.jdt.ls.core.id1" \
        --add-flags "-Dosgi.bundles.defaultStartLevel=4" \
        --add-flags "-Declipse.product=org.eclipse.jdt.ls.core.product" \
        --add-flags "-Dosgi.sharedConfiguration.area=$out/share/config" \
        --add-flags "-Dosgi.sharedConfiguration.area.readOnly=true" \
        --add-flags "-Dosgi.checkConfiguration=true" \
        --add-flags "-Dosgi.configuration.cascaded=true" \
        --add-flags "-Dlog.level=ALL" \
        --add-flags "-noverify" \
        --add-flags "\$JAVA_OPTS" \
        --add-flags "-jar $launcher" \
        --add-flags "--add-modules=ALL-SYSTEM" \
        --add-flags "--add-opens java.base/java.util=ALL-UNNAMED" \
        --add-flags "--add-opens java.base/java.lang=ALL-UNNAMED"
    '';
})

{ pkgs ? import <nixpkgs> {} }:
[
  (
    pkgs.callPackage
    ./.
    {
      mw-name = "test-mw";

      my-domains =
        [
          "test.com"
          "somereallylongnamethatdoesnotexist.com"
        ];
    }
  )

  (
    pkgs.callPackage
    ./.
    {
      mw-name = "empty-mw";

      my-domains =
        [
        ];
    }
  )
]

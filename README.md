# Environment in `run` vs. `run_shell` in nixpkgs provided Bazel

The environment, `$PATH` specifically, differs between [`ctx.action.run`][run]
and [`ctx.action.run_shell`][run_shell] for Bazel provided by nixpkgs.

[run]: https://docs.bazel.build/versions/3.3.0/skylark/lib/actions.html#run
[run_shell]: https://docs.bazel.build/versions/3.3.0/skylark/lib/actions.html#run_shell

Execute the following commands to observe the issue:

```
$ nix-shell --pure --run 'bazel build //:all'
$ cat bazel-bin/using-run.txt
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
readlink is /usr/bin/readlink
$ cat bazel-bin/using-run-shell.txt
/nix/store/58in3hsawf6g1adx99sphi460nzmaqxq-bash-4.4-p23/bin:/nix/store/vssdbs9s059qm5rqpw5q25z3c2d065f7-coreutils-8.31/bin:/nix/store/i13xf7dasqs66ylbnkbprg742a5izh8r-findutils-4.7.0/bin:/nix/store/nw699blhmjls6j1xbb938a1rjq6bw3jf-gawk-5.1.0/bin:/nix/store/dh5d3cpxwk5aixgphx0b61rxq9bfdmlr-gnugrep-3.4/bin:/nix/store/4mwsggbn3gijwixc09jwzh8l42h15n4m-gnutar-1.32/bin:/nix/store/zx7fxdqymhhgrqv6gfynsqzp7dmgn2hs-gnused-4.8/bin:/nix/store/bryws27lqm1j7vlssrd9xzqk9pf5rvlz-gzip-1.10/bin:/nix/store/vb47vacr597kabig0gvaqq2lk2wjfxnw-which-2.21/bin:/nix/store/jvbw3n6v3mp4yx33h7fa2x1zdak40g2a-unzip-6.0/bin:/nix/store/b081hh3zm012vqnwr3srgkvsbzmngkzf-file-5.39/bin:/nix/store/4ipxmrbv36fnaw6i5nfv2ccqdb4c94c2-zip-3.0/bin
readlink is /nix/store/vssdbs9s059qm5rqpw5q25z3c2d065f7-coreutils-8.31/bin/readlink
```

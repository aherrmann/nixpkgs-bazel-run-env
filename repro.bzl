def _using_run_impl(ctx):
    args = ctx.actions.args()
    args.add(ctx.outputs.out.path)
    ctx.actions.run(
        outputs = [ctx.outputs.out],
        arguments = [args],
        executable = ctx.executable._script,
    )

using_run = rule(
    _using_run_impl,
    attrs = {
        "out": attr.output(),
        "_script": attr.label(
            cfg = "host",
            default = Label("//:script"),
            executable = True,
        ),
    },
)

def _using_run_shell_impl(ctx):
    args = ctx.actions.args()
    args.add(ctx.outputs.out.path)
    ctx.actions.run_shell(
        outputs = [ctx.outputs.out],
        inputs = [ctx.file._script],
        arguments = [args],
        command = """\
./{script} "$@"
""".format(
            script = ctx.file._script.path,
        ),
    )

using_run_shell = rule(
    _using_run_shell_impl,
    attrs = {
        "out": attr.output(),
        "_script": attr.label(
            allow_single_file = True,
            default = Label("//:script.sh"),
        ),
    },
)

# Defines targets on the executable

# Required defined variables:
# * exe (build_target)
# * openocd_cfg (file)


size = find_program('arm-none-eabi-size')
objcopy = find_program('arm-none-eabi-objcopy')
stinfo = find_program('st-info')
stflash = find_program('st-flash')
openocd = find_program('openocd')

openocd_cfg = ''

run_target('size',
  command: [
    size, '-B', exe,
  ],
)


hex = custom_target('hex',
  input : exe,
  output: meson.project_name() + '.hex',
  command: [
    objcopy,
    '-Obinary',
    '@INPUT@',
    '@OUTPUT@',
  ],
)

# Keep the commands as single arguments with spaces !
run_target('flash'
  command: [
    openocd, '-f', openocd_cfg,
    '-c', 'reset_config none separate',
    '-c', 'init',
    '-c', 'reset init',
    '-c', 'flash write_image erase @0@"'.format(hex),
    '-c', 'reset',
    '-c', 'shutdown',
  ],
)

run_target('debug'
  command: [
    find_program('debug_openocd_gdb.sh'),
    openocd_cfg,
    exe
  ]
)

# STlink programmer related commands
# run_target('probe',
#   command: [
#     stinfo, '--probe'
#   ],
# )

set nomore

let s:tmp = $VIM_SETTINGS_TEST_TMP

call assert_equal(0, &loadplugins)
call assert_equal(':write<CR>', maparg('<Space>w', 'n'))
call assert_equal(':edit ', maparg('<Space>e', 'n'))
call assert_equal(':bprevious<CR>', maparg('[b', 'n'))
call assert_true(exists(':CopyRelativePath'))

if !empty(v:errors)
  call writefile(v:errors, s:tmp . '/minimal-errors.log')
  cquit 1
endif

qa!

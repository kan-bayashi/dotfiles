from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus
from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name
from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.keys import Keys


ip = get_ipython()


def switch_to_navigation_mode(event):
    vi_state = event.cli.vi_state
    vi_state.input_mode = InputMode.NAVIGATION


if getattr(ip, 'pt_app', None):
    registry = ip.pt_app.key_bindings
    # use <C-o> as <esc> in vim mode
    registry.add_binding(Keys.ControlO,
                         filter=(HasFocus(DEFAULT_BUFFER)
                                 & ViInsertMode()))(switch_to_navigation_mode)
    # use <C-o><C-o> as clear screen
    registry.add_binding(Keys.ControlO, Keys.ControlO,
                         filter=(HasFocus(DEFAULT_BUFFER)
                                 & ViInsertMode()))(get_by_name('clear-screen'))

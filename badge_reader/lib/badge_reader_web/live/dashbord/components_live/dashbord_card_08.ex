defmodule BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard08 do
  use BadgeReaderWeb, :live_component
  import BadgeReaderWeb.EditMenu

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{is_open: is_open, on_toggle: on_toggle}, socket) do
    {:ok,
    socket
    |> assign(:is_open, is_open)
    |> assign(:on_toggle, on_toggle)}
  end

  def render(assigns) do
  ~H"""
    <div class="col-span-full xl:col-span-6 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <header class="border-b border-gray-100 dark:border-gray-700/60">
        <div class="w-full px-5 pt-4 flex justify-between">
          <h2 class="font-semibold text-gray-800 dark:text-gray-100">Activités récentes</h2>
          <.edit_menu is_open={@is_open} on_toggle={@on_toggle}>
            <ul class="text-sm">
              <li>
                <button class="block w-full text-left font-medium text-black dark:text-gray-200 hover:text-gray-500 dark:hover:text-white py-1.5 px-3">
                  Option 1
                </button>
              </li>
              <li>
                <button class="block w-full text-left font-medium text-black dark:text-gray-200 hover:text-gray-500 dark:hover:text-white py-1.5 px-3">
                  Option 2
                </button>
              </li>
              <li class="border-t border-gray-700 mt-1 pt-1">
                <button class="block w-full text-left font-medium text-red-500 hover:text-red-400 py-1.5 px-3">
                  Remove
                </button>
              </li>
            </ul>
          </.edit_menu>
        </div>
      </header>
      <div class="p-3">

        <%!-- Card content --%>
        <%!-- "Today" group --%>
        <div>
          <header class="text-xs uppercase text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-700/50 rounded-xs font-semibold p-2">Aujourd'hui</header>
          <ul class="my-1">
            <%!-- Item --%>
            <li class="flex px-2">
              <div class="w-9 h-9 rounded-full shrink-0 bg-green-500 my-2 mr-3">
                <svg class="w-9 h-9 fill-current text-white" viewBox="0 0 36 36">
                  <path d="M18.3 11.3l-1.4 1.4 4.3 4.3H11v2h10.2l-4.3 4.3 1.4 1.4L25 18z" />
                </svg>
              </div>
              <div class="grow flex items-center border-b border-gray-100 dark:border-gray-700/60 text-sm py-2">
                <div class="grow flex justify-between">
                  <div class="self-center"><a class="font-medium text-gray-800 hover:text-gray-900 dark:text-gray-100 dark:hover:text-white" href="#0">Olga Semklo</a> est arriver a Colint</div>
                  <div class="shrink-0 self-end ml-2">
                    <a class="font-medium text-yellow-500 hover:text-yellow-600 dark:hover:text-yellow-400" href="#0">View<span class="hidden sm:inline"> -&gt;</span></a>
                  </div>
                </div>
              </div>
            </li>
            <%!-- Item --%>
            <li class="flex px-2">
              <div class="w-9 h-9 rounded-full shrink-0 bg-red-500 my-2 mr-3">
                <svg class="w-9 h-9 fill-current text-white" viewBox="0 0 36 36">
                  <path d="M17.7 24.7l1.4-1.4-4.3-4.3H25v-2H14.8l4.3-4.3-1.4-1.4L11 18z" />
                </svg>
              </div>
              <div class="grow flex items-center border-b border-gray-100 dark:border-gray-700/60 text-sm py-2">
                <div class="grow flex justify-between">
                  <div class="self-center"><a class="font-medium text-gray-800 hover:text-gray-900 dark:text-gray-100 dark:hover:text-white" href="#0">Nick Mark</a> viens de partir</div>
                  <div class="shrink-0 self-end ml-2">
                    <a class="font-medium text-yellow-500 hover:text-yellow-600 dark:hover:text-yellow-400" href="#0">View<span class="hidden sm:inline"> -&gt;</span></a>
                  </div>
                </div>
              </div>
            </li>
            <%!-- Item --%>
            <li class="flex px-2">
              <div class="w-9 h-9 rounded-full shrink-0 bg-red-500 my-2 mr-3">
                <svg class="w-9 h-9 fill-current text-white" viewBox="0 0 36 36">
                  <path d="M17.7 24.7l1.4-1.4-4.3-4.3H25v-2H14.8l4.3-4.3-1.4-1.4L11 18z" />
                </svg>
              </div>
              <div class="grow flex items-center text-sm py-2">
                <div class="grow flex justify-between">
                  <div class="self-center"><a class="font-medium text-gray-800 hover:text-gray-900 dark:text-gray-100 dark:hover:text-white" href="#0">Patrick Sullivan</a> viens de partir</div>
                  <div class="shrink-0 self-end ml-2">
                    <a class="font-medium text-yellow-500 hover:text-yellow-600 dark:hover:text-yellow-400" href="#0">View<span class="hidden sm:inline"> -&gt;</span></a>
                  </div>
                </div>
              </div>
            </li>
          </ul>
        </div>
        <%!-- "Yesterday" group --%>
        <div>
          <header class="text-xs uppercase text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-700/50 rounded-xs font-semibold p-2">Hier</header>
          <ul class="my-1">
            <%!-- Item --%>
            <li class="flex px-2">
              <div class="w-9 h-9 rounded-full shrink-0 bg-red-500 my-2 mr-3">
                <svg class="w-9 h-9 fill-current text-white" viewBox="0 0 36 36">
                  <path d="M17.7 24.7l1.4-1.4-4.3-4.3H25v-2H14.8l4.3-4.3-1.4-1.4L11 18z" />
                </svg>
              </div>
              <div class="grow flex items-center border-b border-gray-100 dark:border-gray-700/60 text-sm py-2">
                <div class="grow flex justify-between">
                  <div class="self-center"><a class="font-medium text-gray-800 hover:text-gray-900 dark:text-gray-100 dark:hover:text-white" href="#0">Burak Long</a> viens de partir</div>
                  <div class="shrink-0 self-end ml-2">
                    <a class="font-medium text-yellow-500 hover:text-yellow-600 dark:hover:text-yellow-400" href="#0">View<span class="hidden sm:inline"> -&gt;</span></a>
                  </div>
                </div>
              </div>
            </li>
            <%!-- Item --%>
            <li class="flex px-2">
              <div class="w-9 h-9 rounded-full shrink-0 bg-green-500 my-2 mr-3">
                <svg class="w-9 h-9 fill-current text-white" viewBox="0 0 36 36">
                  <path d="M18.3 11.3l-1.4 1.4 4.3 4.3H11v2h10.2l-4.3 4.3 1.4 1.4L25 18z" />
                </svg>
              </div>
              <div class="grow flex items-center text-sm py-2">
                <div class="grow flex justify-between">
                  <div class="self-center"><a class="font-medium text-gray-800 hover:text-gray-900 dark:text-gray-100 dark:hover:text-white" href="#0">Alex Shatov</a> est arriver a Colint</div>
                  <div class="shrink-0 self-end ml-2">
                    <a class="font-medium text-yellow-500 hover:text-yellow-600 dark:hover:text-violet-400" href="#0">View<span class="hidden sm:inline"> -&gt;</span></a>
                  </div>
                </div>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  """
  end
end

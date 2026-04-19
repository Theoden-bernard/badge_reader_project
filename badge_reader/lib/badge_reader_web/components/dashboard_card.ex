defmodule BadgeReaderWeb.DashboardCard do
  use Phoenix.Component
  import BadgeReaderWeb.ChartComponents
  import BadgeReaderWeb.EditMenu

  def dashboard_card_01(assigns) do
    ~H"""
    <div class="flex flex-col col-span-full sm:col-span-6 xl:col-span-4 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="px-5 pt-5">
        <header class="flex justify-between items-start mb-2">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">
            Staff
          </h2>
          <%!-- Menu button --%>
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

        </header>
        <div class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase mb-1">
          Personne
        </div>
        <div class="flex items-start">
          <div class="text-3xl font-bold text-gray-800 dark:text-gray-100 mr-2">
            50
          </div>
          <div class="text-sm font-medium text-green-700 px-1.5 bg-green-500/20 rounded-full">
            +2%
          </div>
        </div>
        <div class="grow max-h-[128px] -mx-2 -mb-2">
        <.native_sparkline data={[2, 15, 8, 22, 18, 20, 12, 14, 18]} />
        </div>
      </div>
    </div>
    """
  end

  def dashboard_card_02(assigns) do
    ~H"""
    <div class="flex flex-col col-span-full sm:col-span-6 xl:col-span-4 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="px-5 pt-5">
        <header class="flex justify-between items-start mb-2">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">
            Étudiants
          </h2>
          <%!-- Menu button --%>
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
        </header>
        <div class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase mb-1">
          Personne
        </div>
        <div class="flex items-start">
          <div class="text-3xl font-bold text-gray-800 dark:text-gray-100 mr-2">17</div>
          <div class="text-sm font-medium text-red-500 px-1.5 bg-red-500/20 rounded-full">-5%</div>
        </div>
      </div>
      <div class="grow max-sm:max-h-[128px] max-h-[128px]">
        <.native_sparkline data={[2, 6, 8, 18, 8, 20, 12, 14, 10]} />
      </div>
    </div>
    """
  end

  def dashboard_card_03(assigns) do
    ~H"""
    <div class="flex flex-col col-span-full sm:col-span-6 xl:col-span-4 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="px-5 pt-5">
        <header class="flex justify-between items-start mb-2">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">Total</h2>

          <%!-- Menu button --%>
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
        </header>
        <div class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase mb-1">Personne</div>
        <div class="flex items-start">
          <div class="text-3xl font-bold text-gray-800 dark:text-gray-100 mr-2">104</div>
          <div class="text-sm font-medium text-green-700 px-1.5 bg-green-500/20 rounded-full">+20%</div>
        </div>
      </div>
      <div class="grow max-sm:max-h-[128px] xl:max-h-[128px]">
        <.native_sparkline data={[10, 15, 8, 22, 18, 20, 12, 14, 18]}/>
      </div>
    </div>
    """
  end

  def dashboard_card_04(assigns) do
    ~H"""
    <div class="flex flex-col col-span-full sm:col-span-6 xl:col-span-4 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <header class="border-b border-gray-100 dark:border-gray-700/60 flex items-center">
        <div class="w-full px-5 pt-4 flex justify-between">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">Prog VS Market</h2>
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

      <%!-- <BarChart data={chartData} width={595} height={248} /> --%>
    </div>
    """
  end

  def dashboard_card_05(assigns) do
    ~H"""
    <div class="flex flex-col col-span-full sm:col-span-6 xl:col-span-4 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <header class="border-b border-gray-100 dark:border-gray-700/60 flex items-center">
        <div class="w-full px-5 pt-4 flex justify-between">
          <h2 class="font-semibold text-gray-800 dark:text-gray-100">En direct</h2>
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
      <.native_sparkline data={[10, 10, 24, 2, 5, 20, 10, 24, 18]}/>
    </div>
    """
  end

  def dashboard_card_06(assigns) do
    ~H"""
    <div class="flex flex-col col-span-full sm:col-span-6 xl:col-span-4 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <header class="border-b border-gray-100 dark:border-gray-700/60">
        <div class="w-full px-5 pt-4 flex justify-between">
          <h2 class="font-semibold text-gray-800 dark:text-gray-100">Présence</h2>
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
      <.native_pie_chart
        data={[
          ["Staff", 50],
          ["Étudiants", 17],
          ["Visiteurs", 37]
        ]}
      />
    </div>
    """
  end

  attr :customers, :list, default: []
  attr :is_open, :boolean, default: false
  attr :on_toggle, :any, default: nil

  def dashboard_card_07(assigns) do
    ~H"""
    <div class="col-span-full xl:col-span-6 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <header class="border-b border-gray-100 dark:border-gray-700/60">
        <div class="w-full px-5 pt-4 flex justify-between">
          <h2 class="font-semibold text-gray-800 dark:text-gray-100">Activité des utilisateurs</h2>
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
        <%!-- Table --%>
        <div class="overflow-x-auto">
          <table class="table-auto w-full">
            <%!-- Table header --%>
            <thead class="text-xs font-semibold uppercase text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-700/50">
              <tr>
                <th class="p-2 whitespace-nowrap">
                  <div class="font-semibold text-left">Identité</div>
                </th>
                <th class="p-2 whitespace-nowrap">
                  <div class="font-semibold text-left">Email</div>
                </th>
                <th class="p-2 whitespace-nowrap">
                  <div class="font-semibold text-left">Statut</div>
                </th>
                <th class="p-2 whitespace-nowrap">
                  <div class="font-semibold text-center">Présent</div>
                </th>
              </tr>
            </thead>
            <%!-- Table body --%>
            <tbody class="text-sm divide-y divide-gray-100 dark:divide-gray-700/60">
              <%= for customer <- @customers do %>
                <tr>
                  <td class="p-2 whitespace-nowrap">
                    <div class="flex items-center">
                      <div class="w-10 h-10 shrink-0 mr-2 sm:mr-3">
                        <img class="rounded-full" src={customer.image} width="40" height="40" alt={customer.name} />
                      </div>
                      <div class="font-medium text-gray-800 dark:text-gray-100"><%= customer.name %></div>
                    </div>
                  </td>
                  <td class="p-2 whitespace-nowrap">
                    <div class="text-left"><%= customer.email %></div>
                  </td>
                  <td class="p-2 whitespace-nowrap">
                    <div class="text-left text-center"><%= customer.status %></div>
                  </td>
                  <td class="p-2 whitespace-nowrap">
                    <div class="text-lg text-center font-medium text-green-500"><%= customer.present %></div>
                  </td>
                </tr>
              <% end %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    """
  end

  def dashboard_card_08(assigns) do
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

let Hooks = {}

Hooks.ThemeToggle = {
  mounted() {
    this.el.addEventListener("click", () => {
      const isDark = document.documentElement.getAttribute("data-theme") === "dark"
      const newTheme = isDark ? "light" : "dark"
      
      document.documentElement.setAttribute("data-theme", newTheme)
      localStorage.theme = newTheme
    })
  }
}

export default Hooks
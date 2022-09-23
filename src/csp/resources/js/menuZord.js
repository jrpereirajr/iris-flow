
const menuZord = () => {
  const sideBar = document.getElementById('sideBarMenu');
  sideBar.innerHTML = `
    <div class="dlabnav-scroll">
		<ul class="metismenu" id="menu">

			<li><a class="has-arrow " href="javascript:void()" aria-expanded="true">
				<i class="fas fa-project-diagram"></i>
					<span class="nav-text">Flow Editor</span>
				</a>
				<ul aria-expanded="false">
					<li><a href="editor.csp">Flow</a></li>
				</ul>
			</li>

		</ul>
	</div>
  `;

}

menuZord();

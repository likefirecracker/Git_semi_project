function onclick_ok(){
    if(!wrt_frm.n_title.value){
        alert("제목을 써주세요.");
        wrt_frm.n_title,focus();
        return;
    } else if(!wrt_frm.n_pwd.value){
        alert("암호을 써주세요.");
        wrt_frm.n_pwd,focus();
        return;
    }
	const element = document.getElementsByClassName("ql-editor")[0];
	
	document.getElementById("content").value = element.innerHTML;
	
    document.wrt_frm.submit();
}

function delete_ok(){
    if(!del_frm.n_pwd.value){
        alert("암호을 써주세요.");
        del_frm.n_pwd,focus();
        return;
    }
    document.del_frm.submit();
}

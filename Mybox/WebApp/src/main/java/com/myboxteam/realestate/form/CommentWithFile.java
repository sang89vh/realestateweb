package com.myboxteam.realestate.form;

import org.springframework.web.multipart.MultipartFile;

public class CommentWithFile {
	private String objId;
	private int parent;
	private String created;
	private String modified;
	private String content;
	private String[] pings;
	private String fullname;
	private String profile_picture_url;
	private boolean created_by_current_user;
	private int upvote_count;
	private boolean user_has_upvoted;	
	private MultipartFile file;
	private String file_url;
	private String file_mime_type;
	
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getModified() {
		return modified;
	}
	public void setModified(String modified) {
		this.modified = modified;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String[] getPings() {
		return pings;
	}
	public void setPings(String[] pings) {
		this.pings = pings;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getProfile_picture_url() {
		return profile_picture_url;
	}
	public void setProfile_picture_url(String profile_picture_url) {
		this.profile_picture_url = profile_picture_url;
	}
	public boolean isCreated_by_current_user() {
		return created_by_current_user;
	}
	public void setCreated_by_current_user(boolean created_by_current_user) {
		this.created_by_current_user = created_by_current_user;
	}
	public int getUpvote_count() {
		return upvote_count;
	}
	public void setUpvote_count(int upvote_count) {
		this.upvote_count = upvote_count;
	}
	public boolean isUser_has_upvoted() {
		return user_has_upvoted;
	}
	public void setUser_has_upvoted(boolean user_has_upvoted) {
		this.user_has_upvoted = user_has_upvoted;
	}
	public String getFile_url() {
		return file_url;
	}
	public void setFile_url(String file_url) {
		this.file_url = file_url;
	}
	public String getFile_mime_type() {
		return file_mime_type;
	}
	public void setFile_mime_type(String file_mime_type) {
		this.file_mime_type = file_mime_type;
	}
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
}

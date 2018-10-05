package com.spring.domain;

public class SerarchCriteria extends Criteria {
   //page
	//perPageNum
	private String searchType;//검색유형(6가지)
	private String keyword; //검색 키워드, 직접입력된값
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
		public String toString() {
			
			return super.toString()+"SearchCriteria "+"[searchType="+searchType+" , keyword="+keyword+"]";
		}
}

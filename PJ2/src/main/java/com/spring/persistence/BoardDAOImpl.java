package com.spring.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.SerarchCriteria;


@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.spring.persistence.BoardDAO";
	
	
	@Override
	public void create(BoardVO vo) throws Exception {
		session.insert(namespace+".create", vo);

	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		
		return session.selectOne(namespace+".read", bno);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		session.update(namespace+".update", vo);

	}

	@Override
	public void delete(Integer bno) throws Exception {
		session.delete(namespace+".delete", bno);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		
		return session.selectList(namespace+".listAll");
	}
///------------------------------------------------------------------Paging
	@Override
	public List<BoardVO> listPage(int page) throws Exception {
		if(page <= 0) {
			page=1;
		}
		page = (page-1)*10;//페이지 번호
		return session.selectList(namespace+".listPage",page) ;
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		
		return session.selectList(namespace+".listCriteria", cri);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		
		return session.selectOne(namespace+".countPaging", cri);
	}

	
	//---------------------------------------------------------------search
	@Override
	public List<BoardVO> listSearch(SerarchCriteria cri) throws Exception {
		
		return session.selectList(namespace+".listSearch",cri) ;
	}

	@Override
	public int listSearchCount(SerarchCriteria cri) throws Exception {
		
		return session.selectOne(namespace+".listSearchCount", cri);
	}

	//댓글(rno) 카운트
	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("bno", bno);
		paramMap.put("amount", amount);
		
		session.update(namespace+".updateReplyCnt", paramMap);
		
	}
	//원글(bno) 조회수
	@Override
	public void updateViewCnt(Integer bno) throws Exception {
		session.update(namespace+".updateViewCnt", bno);
		
	}
//------------------------------첨부파일
	@Override
	public void addAttach(String fullName) throws Exception {
		session.insert(namespace+".addAttach", fullName);
		
	}

	@Override
	public List<String> getAttach(Integer bno) throws Exception {
		
		return session.selectList(namespace+".getAttach", bno);
	}

	@Override
	public void deleteAttach(Integer bno) throws Exception {
		session.delete(namespace+".deleteAttach", bno);
		
	}

	@Override
	public void replaceAttach(String fullName, Integer bno) throws Exception {//추가 
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("bno", bno);
		paramMap.put("fullName", fullName);
		
		session.insert(namespace+".replaceAttach", paramMap );
		
	}

}

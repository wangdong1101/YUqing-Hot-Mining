package cn.dd.job004;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.ansj.domain.Result;
import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.NlpAnalysis;
import org.apache.hadoop.hive.ql.exec.UDF;

public class CwsV2UDF extends UDF {
	// 用于标记用于去重的natureSet是否已经初始化的标志位
	public boolean natureSetHaveInitFlag = false;
	// 用于词性过滤的set集合初始化
	public Set<String> natureSet = new HashSet<String>();

	public String evaluate(String input, String natureStr) {
		// 如果输入为空，则直接返回空即可
		if (input == null || input.trim().length() == 0) {
			return null;
		}
		if (!natureSetHaveInitFlag && natureStr != null) {
			String[] natureArray = natureStr.split(",");
			for (String nature : natureArray) {
				natureSet.add(nature);
			}
			natureSetHaveInitFlag = true;
		}
		// 采用nlp分词，具备(用户自定义词典/数字识别/人名识别/机构名识别/新词发现)功能
		Result result = NlpAnalysis.parse(input);
		// 如果处理结果为null，则直接返回一个null即可
		if (result == null || result.getTerms() == null) {
			return null;
		}
		// 将分词结果集合返回给变量itemList
		List<Term> termList = result.getTerms();
		// 存储每次分词完成后的词序列集合，词之间以'\001'分隔
		StringBuilder stringBuilder = new StringBuilder();
		// 循环记数器，当counter>0的时候，每次添加元素前先添加分隔符
		int counter = 0;
		// 遍历集合,加入结果集中
		for (Term term : termList) {
			// 判断分词的Term的词性是否包含在词性的白名单中,如果在则加入，否则忽略掉
			if (natureSet.contains(term.getNatureStr())) {
				if (counter > 0) {
					stringBuilder.append('\001');
				}
				stringBuilder.append(term.getName());
				counter++;
			}
		}
		return stringBuilder.toString();
	}

	public static void main(String[] args) {
		String natureList = "n,nr,nr1,nr2,nrj,nrf,ns,nsf,nt,nz,nl,ng,nw,s,v,vd,vn,vf,vx,vi,vl,vg,a,ad,an,ag,al,x,xx";
		System.out.println(new CwsV2UDF()
				.evaluate("河北省石家庄市高新区万达广场", natureList));
	}
}

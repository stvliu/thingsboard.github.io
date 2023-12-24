---
layout: docwithnav

---
<script language="JavaScript">

var dropDownsPopulated = false;

jqueryDefer(initLogic);

function initLogic() {
    $( document ).ready(function() {
      // 当文档加载时，获取元数据 JSON，并启动 tbl 渲染
      $.get("/metadata.txt", function(data, status) {
        metadata = $.parseJSON(data);
        metadata.pages.sort(dynamicSort("t"));
        mainLogic()
        $(window).bind( 'hashchange', function(e) {
          mainLogic();
        });
      });
    });
}

function mainLogic()
{
  // 如果有标签过滤器，则更改表格/下拉输出
  if (!dropDownsPopulated) populateDropdowns();
  var tag=window.location.hash.replace("#","");
  if(tag) {
    tag = $.trim(tag);
    for (i=0;i<tagName.length;i++) {
      querystringTag = tagName[i] + "=";
      if (tag.indexOf(querystringTag) > -1)
      {
        console.log("in mainLog: querystringTag of " + querystringTag + " matches tag of " + tag);
        tag = tag.replace(querystringTag,"");
        selectDropDown(tagName[i],tag);
        topicsFilter(tagName[i],tag,"output");
      }
    }
  } else {
    currentTopics = metadata.pages;
  }
  renderTable(currentTopics,"output");

}

function populateDropdowns()
{
  // 通过对下拉过滤器框的初始化进行函数化来保持 mainLogic() 简短

  for(i=0;i<metadata.pages.length;i++)
  {
    var metadataArrays = [metadata.pages[i].cr,metadata.pages[i].or,metadata.pages[i].mr];
    for(j=0;j<metadataArrays.length;j++)
    {
      if (metadataArrays[j]) {
        for (k=0;k<metadataArrays[j].length;k++) {
          if (typeof storedTagsArrays[j] == 'undefined') storedTagsArrays[j] = new Array();
          storedTagsArrays[j][metadataArrays[j][k][tagName[j]]] = true;
          // ^ conceptList[metadata.pages[i].cr[k].concept] = true; (如果滚动浏览概念)
          // ^ conceptList['container'] = true; (最终结果)
          // ^ objectList[metadata.pages[i].or[k].object] = true; (如果滚动浏览对象)
          // ^ objectList['restartPolicy'] = true; (最终结果)
        }
      }
    }
  }
  var output = new Array();
  for(i=0;i<tagName.length;i++)
  {
    // 呼！所有标签都在 conceptList、objectList 和 commandList 中！
    // 循环遍历它们并通过 html() 注入填充那些下拉框
    output = [];
    output.push("<select id='" + tagName[i] + "' onchange='dropFilter(this)'>");
    output.push("<option>---</option>");
    Object.keys(storedTagsArrays[i]).sort().forEach(function (key) {
      output.push("<option>" + key + "</option>");
    });
    output.push("</select>")
    $(dropDowns[i]).html(output.join(""));
  }
  dropDownsPopulated = true;
}

function dropFilter(srcobj)
{
  // 处理下拉值的变化
  // 下拉菜单的 ID 是命令、对象或概念
  // 这些确切的值是 topicsFilter() 所期望的，加上一个过滤器值
  // 我们从 :selected 的 .text() 中获取
  console.log("dropFilter:" + $(srcobj).attr('id') + ":" + $(srcobj).find(":selected").text());
  topicsFilter($(srcobj).attr('id').replace("#",""),$(srcobj).find(":selected").text(),"output");
  for(i=0;i<tagName.length;i++)
  {
    if($(srcobj).attr('id')!=tagName[i]) selectDropDown(tagName[i],"---");
  }
}

function selectDropDown(type,tag)
{
  // 更改下拉选择而不进行过滤
  $("#" + type).val(tag);
}

</script>
<style>
#filters select{
  font-size: 14px;
  border: 1px #000 solid;
}
#filters {
  padding-top: 20px;
}
</style>

单击标签或使用下拉菜单进行过滤。单击表格标题以进行排序或反向排序。

<p id="filters">
按概念过滤：<span id="conceptFilter" /><br/>
按对象过滤：<span id="objectFilter" /><br/>
按命令过滤：<span id="commandFilter" />
</p>

<div id="output" />
<script lang="ts">
	import Info from '$lib/components/icons/Info.svelte';

	export let content = '';
</script>

<div class="flex my-2 gap-2.5 border px-4 py-3 border-red-600/10 bg-red-600/10 rounded-lg">
	<div class=" self-start mt-0.5">
		<Info className="size-5 text-red-700 dark:text-red-400" />
	</div>

	<div class=" self-center text-sm">
		{console.log('Rendered content:', content)}
		<!-- content 不为 json 的处理补全 -->
		{typeof content === 'string' ? content : (c=>{try{return JSON.stringify(c,(k,v)=>v===undefined?'undefined':v instanceof Node?'[Node]':typeof v==='function'?'[Function]':v)}catch(e){return`[Serialization Error: ${e.message}]`}})(content)}
	</div>
</div>
